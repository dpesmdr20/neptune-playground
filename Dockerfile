FROM openjdk:18-jdk-slim

LABEL maintainer="dpesmdr20@gmail.com"

# Download BlazeGraph jar and place it in the /app directory
ADD https://github.com/blazegraph/database/releases/download/BLAZEGRAPH_2_1_6_RC/blazegraph.jar /app/

# Expose ports
EXPOSE 9999

# Start BlazeGraph
CMD ["java", "-server", "-Xmx4g", "-jar", "/app/blazegraph.jar"]
