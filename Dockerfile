FROM hashicorp/terraform:1.1.7

WORKDIR /home/terraform

RUN apk add --no-cache openssl && apk add --update-cache --upgrade curl && rm -rf /var/cache/apk/* && apk add bash

RUN curl -o /usr/local/bin/waitforit -sSL https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
  chmod +x /usr/local/bin/waitforit

  # change function.zip to your zip archive name
COPY main.tf .
COPY function.zip .

# Initialize terraform
RUN terraform init

ENTRYPOINT [""]

CMD waitforit -h lambda-localstack -p 4566 -t 120 -s -- terraform apply -auto-approve
