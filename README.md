## GRPC POC for RMS
The repository contains an example of how to generate stub code using maven, how to implement a client/server from generated stub code

## How to RUN

## Maven

If you prefer to use Maven:
$ mvn verify
$ # Run the server
$ mvn exec:java -Dexec.mainClass=com.ericsson.iot.rms.grpc.server.HelloWorldServer
$ # In another terminal run the client
$ mvn exec:java -Dexec.mainClass=com.ericsson.iot.rms.grpc.client.HelloWorldClient



