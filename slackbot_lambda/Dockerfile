FROM public.ecr.aws/lambda/python:3.8

WORKDIR /var/task

RUN pip install slack-bolt
RUN pip install requests

COPY app.py .

CMD ["app.lambda_handler"] 

#aws ecr create-repository --repository-name si3mshady-projects -region us-east-1
# aws ecr get-login-password --region us-east-2 |  docker login --username AWS \
# --password-stdin 530182258888.dkr.ecr.us-east-2.amazonaws.com
#sudo docker build . -t si3mshady/workspace-user
#sudo docker tag 70f119814140  538258888.dkr.ecr.us-east-2.amazonaws.com/si3mshady-projects:<custom_tag>
#sudo docker push  538258888.dkr.ecr.us-east-2.amazonaws.com/si3mshady-projects:<custom_tag>aws ecr get-login-password --region us-east-2 | docker login --username AWS \
# aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 530182258888.dkr.ecr.<region>.amazonaws.com
