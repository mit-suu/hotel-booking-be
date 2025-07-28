# ---------- Build stage ----------
FROM maven:3-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# ---------- Run stage ----------
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copy file WAR từ stage trước
COPY --from=build /app/target/hotel-booking-0.0.1-SNAPSHOT.war hotel-booking.war

EXPOSE 8080

# Chạy WAR
ENTRYPOINT ["java", "-jar", "hotel-booking.war"]
