
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
CMD ["./wait-for-it.sh", "-t", "60", "db:5432", "--",\
 "./wait-for-it.sh", "-t", "60", "hotel-service:8082", "--",\ 
 "./wait-for-it.sh", "-t", "60", "session-service:8081", "--",\ 
 "./wait-for-it.sh", "-t", "60","booking-service:8083", "--",\
 "./wait-for-it.sh", "-t", "60","payment-service:8084", "--",\
 "./wait-for-it.sh", "-t", "60","loyalty-service:8085", "--",\
 "./wait-for-it.sh", "-t", "60","report-service:8086",  "--", \
 "java", "-jar", "/app/*.jar"]