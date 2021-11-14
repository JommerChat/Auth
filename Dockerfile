ARG SNOWFLAKE_BASE_URL
ENV snowflake_base_url=${SNOWFLAKE_BASE_URL}
ARG POSTGRES_URL
ENV postgres_url=${POSTGRES_URL}
ARG POSTGRES_USERNAME
ENV postgres_username=${POSTGRES_USERNAME}
ARG POSTGRES_PASSWORD
ENV postgres_password=${POSTGRES_PASSWORD}
ARG OKTA_TOKEN
ENV okta_token=${OKTA_TOKEN}
ARG OKTA_ORG_URL
ENV okta_org_url=${OKTA_ORG_URL}
ARG OKTA_ISSUER
ENV okta_issuer=${OKTA_ISSUER}
ARG OKTA_CLIENTID
ENV okta_clientId=${OKTA_CLIENTID}
ARG OKTA_CLIENTSECRET
ENV okta_clientSecret=${OKTA_CLIENTSECRET}

FROM maven:3.8.3-openjdk-11-slim AS build
RUN mkdir -p /workspace
WORKDIR /workspace
COPY pom.xml /workspace
COPY src /workspace/src
RUN mvn -B package --file pom.xml -DskipTests

FROM openjdk:11-slim
COPY --from=build /workspace/target/*.jar app.jar
EXPOSE 8081
ENTRYPOINT ["java","-jar","app.jar"]
