REM TLS without mutual auth:
mvn exec:java -Dexec.mainClass=com.ericsson.iot.rms.grpc.server.tls.HelloWorldServerTls -Dexec.args="localhost 50440 C:\iot\rms-grpc-poc\rms-grpc-server\src\main\resources\certs\server.crt C:\iot\rms-grpc-poc\rms-grpc-server\src\main\resources\certs\server.pem"

REM  TLS with mutual auth
REM mvn exec:java -Dexec.mainClass=com.ericsson.iot.rms.grpc.server.tls.HelloWorldServerTls -Dexec.args="localhost 50440 C:\iot\rms-grpc-poc\rms-grpc-server\src\main\resources\certs\server.crt C:\iot\rms-grpc-poc\rms-grpc-server\src\main\resources\certs\server.pem C:\iot\rms-grpc-poc\rms-grpc-server\src\main\resources\certs\ca.crt"
