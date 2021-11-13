FROM maven:3.8.3-openjdk-11-slim AS build
RUN mkdir -p /workspace
WORKDIR /workspace
COPY pom.xml /workspace
COPY src /workspace/src
RUN mvn -B package --file pom.xml -DskipTests

FROM openjdk:11-slim
COPY --from=build /workspace/target/*jar-with-dependencies.jar app.jar
EXPOSE 8081
ENTRYPOINT ["java","-jar","app.jar"]