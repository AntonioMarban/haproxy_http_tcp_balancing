FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY Server.java /app/Server.java
RUN javac Server.java
EXPOSE 5000
CMD ["java", "Server"]
