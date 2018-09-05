# GRPC POC for RMS
The repository contains an example of how to generate stub code using maven, how to implement a client/server from generated stub code.This project incudes three modules. it is an example of maven multiple modules project.

1. rms-grpc-api: includes protobuffer files, this modules will be used with other modules
2. rms-grpc-server: implements gRPC server 
3. rms-grpc-client: implements gRPC client to call gRPC server

[Source] https://github.com/grpc/grpc-java/tree/master/examples


## How to RUN POC with Maven

### Hello world

```text
$ mvn verify
$ mvn install
$ # Run the server
$ mvn exec:java -Dexec.mainClass=com.ericsson.iot.rms.grpc.server.HelloWorldServer
$ # In another terminal run the client
$ mvn exec:java -Dexec.mainClass=com.ericsson.iot.rms.grpc.client.HelloWorldClient
```


### Hello World with TLS 

Running the hello world with TLS is the same as the normal hello world, but takes additional args:

**hello-world-tls-server**:

```text
USAGE: HelloWorldServerTls host port certChainFilePath privateKeyFilePath [trustCertCollectionFilePath]
  Note: You only need to supply trustCertCollectionFilePath if you want to enable Mutual TLS.
```

**hello-world-tls-client**:

```text
USAGE: HelloWorldClientTls host port [trustCertCollectionFilePath] [clientCertChainFilePath] [clientPrivateKeyFilePath]
  Note: clientCertChainFilePath and clientPrivateKeyFilePath are only needed if mutual auth is desired. And if you specify clientCertChainFilePath you must also specify clientPrivateKeyFilePath
```

#### Generating self-signed certificates for use with grpc

You can use the following script to generate self-signed certificates for grpc-java including the hello world with TLS examples:

```bash
# Changes these CN's to match your hosts in your environment if needed.
SERVER_CN=localhost
CLIENT_CN=localhost # Used when doing mutual TLS

echo Generate CA key:
openssl genrsa -passout pass:1111 -des3 -out ca.key 4096
echo Generate CA certificate:
# Generates ca.crt which is the trustCertCollectionFile
openssl req -passin pass:1111 -new -x509 -days 365 -key ca.key -out ca.crt -subj "/CN=${SERVER_CN}"
echo Generate server key:
openssl genrsa -passout pass:1111 -des3 -out server.key 4096
echo Generate server signing request:
openssl req -passin pass:1111 -new -key server.key -out server.csr -subj "/CN=${SERVER_CN}"
echo Self-signed server certificate:
# Generates server.crt which is the certChainFile for the server
openssl x509 -req -passin pass:1111 -days 365 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt 
echo Remove passphrase from server key:
openssl rsa -passin pass:1111 -in server.key -out server.key
echo Generate client key
openssl genrsa -passout pass:1111 -des3 -out client.key 4096
echo Generate client signing request:
openssl req -passin pass:1111 -new -key client.key -out client.csr -subj "/CN=${CLIENT_CN}"
echo Self-signed client certificate:
# Generates client.crt which is the clientCertChainFile for the client (need for mutual TLS only)
openssl x509 -passin pass:1111 -req -days 365 -in client.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out client.crt
echo Remove passphrase from client key:
openssl rsa -passin pass:1111 -in client.key -out client.key
echo Converting the private keys to X.509:
# Generates client.pem which is the clientPrivateKeyFile for the Client (needed for mutual TLS only)
openssl pkcs8 -topk8 -nocrypt -in client.key -out client.pem
# Generates server.pem which is the privateKeyFile for the Server
openssl pkcs8 -topk8 -nocrypt -in server.key -out server.pem
```
if you generate certificates under windows , you might need to install openssl and run batch file
```
grpc_key.bat
```
and copy generated files to the location of project: path\sslcerts\

#### Hello world example with TLS (no mutual auth):

```
# Server
mvn exec:java -Dexec.mainClass=com.ericsson.iot.rms.grpc.server.tls.HelloWorldServerTls -Dexec.args="localhost 50440 paths\sslcerts\server.crt path\sslcerts\server.pem"

# Client
mvn exec:java -Dexec.mainClass=com.ericsson.iot.rms.grpc.client.tls.HelloWorldClientTls -Dexec.args="localhost 50440 path\sslcerts\ca.crt"

```

#### Hello world example with TLS with mutual auth:

```bash
# Server
mvn exec:java -Dexec.mainClass=com.ericsson.iot.rms.grpc.server.tls.HelloWorldServerTls -Dexec.args="localhost 50440 paths\sslcerts\server.crt path\sslcerts\server.pem path\sslcerts\ca.crt"
# Client
mvn exec:java -Dexec.mainClass=com.ericsson.iot.rms.grpc.client.tls.HelloWorldClientTls -Dexec.args="localhost 50440 path\sslcerts\ca.crt path\sslcert\client.crt path\sslcert\client.pem"
```

That's it!

