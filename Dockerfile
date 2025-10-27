# Use official OpenJDK 21 image
FROM openjdk:21-jdk-slim

# Set working directory
WORKDIR /minecraft

# Install curl to download server.jar
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Download the Minecraft server JAR from your URL
RUN curl -o server.jar https://piston-data.mojang.com/v1/objects/95495a7f485eedd84ce928cef5e223b757d2f764/server.jar

# Accept the EULA
RUN echo "eula=true" > eula.txt

# Create persistent world directory
VOLUME ["/minecraft/world"]

# Expose default Minecraft port
EXPOSE 25565

# Default command to run the server
CMD ["java", "-Xmx2G", "-Xms1G", "-jar", "server.jar", "nogui"]
