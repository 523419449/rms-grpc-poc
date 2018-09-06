package com.ericsson.iot.rms.grpc.server;

import java.util.logging.Logger;

import com.ericsson.iot.rms.grpc.api.GreeterGrpc;
import com.ericsson.iot.rms.grpc.api.HelloReply;
import com.ericsson.iot.rms.grpc.api.HelloRequest;

import io.grpc.stub.StreamObserver;

public class GreeterImpl extends GreeterGrpc.GreeterImplBase {

	 private static final Logger logger = Logger.getLogger(GreeterImpl.class.getName());
	@Override
	public void sayHello(HelloRequest req, StreamObserver<HelloReply> responseObserver) {
		logger.info("Receive request: " + req.toString());
		HelloReply reply = HelloReply.newBuilder().setMessage("Hello " + req.getName()).build();
		logger.info("Send response: " + reply.toString());
		responseObserver.onNext(reply);
		responseObserver.onCompleted();
	}
}
