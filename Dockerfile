FROM amazonlinux:latest

WORKDIR /app

COPY requirements.txt .
COPY lambda_function.py .

RUN yum install python3-pip -y

RUN yum install wget -y
RUN yum install unzip -y 
RUN pip3  install selenium==3.141.0  && pip3 install -r requirements.txt

RUN /usr/bin/wget https://chromedriver.storage.googleapis.com/91.0.4472.101/chromedriver_linux64.zip

RUN unzip chromedriver_linux64.zip && rm chromedriver_linux64.zip

RUN  wget https://raw.githubusercontent.com/si3mshady/aws_lambda_functions-/master/google-chrome-repo.txt
RUN  mv google-chrome-repo.txt  /etc/yum.repos.d/google-chrome.repo
RUN yum install google-chrome-stable -y 

ENTRYPOINT ["python3", "lambda_function.py"] 

# CMD ["lambda_function.py"] 


#sudo docker build . -t si3mshady/workspace-user
#aws ecr create-repository --repository-name si3mshady-projects --image-scanning-configuration scanOnPush=true --region us-east-
# sudo docker tag 378dea7e3307  530182258888.dkr.ecr.us-east-2.amazonaws.com/si3mshady-projects:workspace-user-aws-image
#aws ecr get-login-password --region us-east-2 | sudo docker login --username AWS --password-stdin   530182258888.dkr.ecr.us-east-2.amazonaws.com
# sudo docker push    530182258888.dkr.ecr.us-east-2.amazonaws.com/si3mshady-projects:workspace-user-aws-image
# #530182258888.dkr.ecr.us-east-2.amazonaws.com/si3mshady-projects@sha256:f3a38249facd8e1d5c31e3536d43acbe85520aa810760ede5c21391790712fa3
# # https://praneeth-kandula.medium.com/running-chromedriver-and-selenium-in-python-on-an-aws-ec2-instance-2fb4ad633bb5
# #https://hub.docker.com/r/amazon/aws-lambda-python
# #https://stackoverflow.com/questions/64856328/selenium-works-on-aws-ec2-but-not-on-aws-lambda
#https://tecadmin.net/install-python-3-7-on-centos/

