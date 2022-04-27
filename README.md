# Invoke PHP script deployed to Oracle Cloud Functions using Fn HotWrap

Oracle Functions is a serverless platform that lets developers create, run, and scale applications without managing any infrastructure. Functions are based on the open-source Fn Project and the code based on Functions typically runs for a short duration, and customers need to pay only for the resources they consume.

The Fn Project provides function development kits (FDKs) for Java, Python, Node, Go, and Ruby, and in addition, lets you bring your own Dockerfile. Here we are trying to run a PHP application using Oracle Functions. Fn HotWrap is a beta tool that lets you run Unix commands as functions. Here is the procedure I followed to run a HelloWorld program built in PHP using Oracle Cloud Functions.

Sample.php

Firstly, let us create a Sample PHP application.

```#Sample.php 
<?php
echo "Hello World!";
echo "The Best PHP Examples";
?>```

Func.yaml
The func.yaml file contains the configuration for your function project. Here we are using the runtime as Docker.

```#Func.yaml
schema_version: 20180708
name: revfunc
version: 0.0.1
runtime: docker```

Dockerfile

Docker builds images by reading the instructions in Dockerfile, which contains all commands needed to build a given image. We will be using HotWrap binary in order to run the PHP code.

#Dockerfile
FROM alpine:latest
FROM php:7.4-cli
# Install hotwrap binary in your container
COPY --from=fnproject/hotwrap:latest  /hotwrap /hotwrap
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
# Run the PHP code
CMD [ "php", "./sample.php" ]
# Update entrypoint to use hotwrap, this will wrap your command
ENTRYPOINT ["/hotwrap"]

Go ahead and deploy the Function using Cloud Shell:

Setup fn CLI on Cloud Shell

fn list context
fn use context us-ashburn-1
fn update context oracle.compartment-id <<Compartment ID>>
fn update context registry iad.ocir.io/[tenancyname]/[repo-name-prefix]
docker login -u 'natdcshjumpstartprod/oracleidentitycloudservice/[email]' iad.ocir.io
fn list apps

Create, deploy, and invoke your function

cd Hotwrap
fn -v deploy --app <<Application Name>>

Here is the output:
fn invoke <<Application name>> revfunc
