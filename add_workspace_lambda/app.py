import boto3

ssm = boto3.client('ssm', region_name='us-east-1')
ws = boto3.client('workspaces', region_name='us-east-1')

def lambda_handler(event,context):
    
    #event looks like:
    # 'username=anotherone&command_id=9a53d0f8-3f55-4a2a-991f-626a11ce53ae&instance_id=i-0b985850324c24562'

    username, command_id, instance_id = [x.split('=')[1] for x in event.get('body').split('&')]
    response = ssm.get_command_invocation( CommandId=command_id, InstanceId=instance_id )

    #check the command status 
    while response.get('Status') != 'Success':
        response = ssm.get_command_invocation( CommandId=command_id, InstanceId=instance_id )       
        print(response.get('Status'))
   
    directory_id = "d-9067682be8"
    bundle_id = "wsb-clj85qzj1"
    entry = {"Workspaces":[
        {
                'DirectoryId':directory_id,
                'UserName': username,
                'BundleId': bundle_id,
                
                'Tags': [
                    {
                        'Key': 'devops',
                        'Value': 'slackbot'
                    },
                ]
            }
    ]}
    response=ws.create_workspaces(**entry)
    print(response)
    return { "status":200 }
   
 

