# Use official OpenJDK 21 image
FROM openjdk:21-jdk-slim

# Set working directory
WORKDIR /minecraft

# Copy your server.jar into the container (or download it later)
COPY server.jar .

# Accept EULA
RUN echo "eula=true" > eula.txt

# Create persistent world directory
VOLUME ["/minecraft/world"]

# Expose default Minecraft port
EXPOSE 25565

# Default command to run the server
CMD ["java", "-Xmx2G", "-Xms1G", "-jar", "server.jar", "nogui"]
