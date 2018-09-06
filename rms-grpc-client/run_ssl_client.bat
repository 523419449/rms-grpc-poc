REM TLS without mutual auth:
mvn exec:java -Dexec.mainClass=com.ericsson.iot.rms.grpc.client.tls.HelloWorldClientTls -Dexec.args="localhost 50440 C:\iot\rms-grpc-poc\rms-grpc-client\src\main\resources\certs\ca.crt"

REM TLS with mutual auth
REM mvn exec:java -Dexec.mainClass=com.ericsson.iot.rms.grpc.client.tls.HelloWorldClientTls -Dexec.args="localhost 50440 C:\iot\rms-grpc-poc\rms-grpc-client\src\main\resources\certs\ca.crt C:\iot\rms-grpc-poc\rms-grpc-client\src\main\resources\certs\client.crt C:\iot\rms-grpc-poc\rms-grpc-client\src\main\resources\certs\client.pem"
