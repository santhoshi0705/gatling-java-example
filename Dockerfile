# Stage 1: Build the Java project using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Build the project (compiles classes and downloads dependencies)
RUN mvn clean compile

# Optional: run Gatling tests during build
# RUN mvn gatling:test -Dgatling.simulationClass=com.example.YourSimulationClass

# Stage 2: Runtime container using Java only (optional if you want to run later)
FROM eclipse-temurin:17-jdk

# Set working directory
WORKDIR /app

# Copy built files from the previous stage
COPY --from=build /app /app

# Default command: Run a Gatling test (change simulation class as needed)
CMD ["mvn", "gatling:test", "-Dgatling.simulationClass=com.jecklgamis.simulation.BasicSimulation"]
