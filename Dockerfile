FROM  maven:3.8.5-openjdk-17 as maven

RUN mkdir -p /app
WORKDIR /app
COPY pom.xml /app
RUN mvn dependency:resolve
COPY . /app
RUN mvn clean install -DskipTests

FROM amazoncorretto:17.0.7-alpine

RUN apk --no-cache add msttcorefonts-installer fontconfig && \
    update-ms-fonts && \
    fc-cache -f
#    && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections \
#    && apt-get install -y ttf-mscorefonts-installer

RUN mkdir -p /app
WORKDIR /app
#Move over the War file from previous build step
COPY --from=maven /app/target/*.jar /app/app.jar

EXPOSE 8080
ENV JAVA_OPTS="-Xms1024m -Xmx4096m -XX:MetaspaceSize=512m -XX:MaxMetaspaceSize=512m -Xss512k"
ENV SERVER_PORT=8080
#CMD ["/bin/java", $JAVA_OPTS, "-jar","/app/app.jar", " --server.port=8080"]
CMD ["sh", "-c", "java $JAVA_OPTS -jar -Dserver.port=$SERVER_PORT app.jar"]

