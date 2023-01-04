FROM registry.cn-beijing.aliyuncs.com/mytest1_1/graalvm:17-22.3-gradle

ADD . /build
WORKDIR /build
RUN gradle nativeCompile

FROM oraclelinux:7-slim
# Add Spring Boot Native app spring-boot-graal to Container
COPY --from=0 "/build/native/nativeCompile/demo1" spring-native-demo
ENV PORT=8080
# Fire up our Spring Boot Native app by default
CMD [ "sh", "-c", "./spring-native-demo -Dserver.port=$PORT" ]