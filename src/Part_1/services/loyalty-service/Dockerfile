
FROM maven:3.8.4-jdk-8 AS build

WORKDIR /app
COPY .mvn .mvn 
COPY pom.xml ./
COPY mvnw ./

RUN mvn -B dependency:go-offline --batch-mode --errors

COPY src ./src
RUN mvn -B package -DskipTests

FROM openjdk:8-jdk-alpine
WORKDIR /app
COPY . .
RUN apk add --no-cache bash
RUN chmod +x wait-for-it.sh
COPY --from=build /app/target/*.jar /app/*.jar
CMD ["./wait-for-it.sh", "-t", "60", "db:5432",  "--", "java", "-jar", "/app/*.jar"]