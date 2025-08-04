    #FROM jupyter/all-spark-notebook:latest

    # Specify the version of the MongoDB Spark Connector you need
    #ARG MONGO_SPARK_CONNECTOR_VERSION=10.5.0 
    #ARG SCALA_VERSION=2.12 # Or 2.13 depending on your Spark version

    # Download the MongoDB Spark Connector JAR
    #RUN wget -P /usr/local/spark/jars/ https://repo1.maven.org/maven2/org/mongodb/spark/mongo-spark-connector_${SCALA_VERSION}/${MONGO_SPARK_CONNECTOR_VERSION}/mongo-spark-connector_${SCALA_VERSION}-${MONGO_SPARK_CONNECTOR_VERSION}.jar

    # Optional: Download MongoDB Java Driver dependencies if needed (e.g., for specific features or older connector versions)
    # RUN wget -P /usr/local/spark/jars/ https://repo1.maven.org/maven2/org/mongodb/mongodb-driver-sync/4.11.1/mongodb-driver-sync-4.11.1.jar
    # RUN wget -P /usr/local/spark/jars/ https://repo1.maven.org/maven2/org/mongodb/bson/4.11.1/bson-4.11.1.jar
    # RUN wget -P /usr/local/spark/jars/ https://repo1.maven.org/maven2/org/mongodb/mongodb-driver-core/4.11.1/mongodb-driver-core-4.11.1.jar

    # File: ./spark/Dockerfile

# Use the official Jupyter all-spark-notebook as the base image
# This matches the 'FROM' in my previous answer.
FROM jupyter/all-spark-notebook:latest

# Switch to the root user to install packages
USER root

# Define the MongoDB Spark Connector version
ARG MONGO_SPARK_CONNECTOR_VERSION="10.5.0"
ARG SCALA_VERSION="2.12"

# Install the connector JAR into Spark's autoloader directory and clean up
RUN apt-get update && apt-get install -y --no-install-recommends wget && \
    wget "https://repo1.maven.org/maven2/org/mongodb/spark/mongo-spark-connector_${SCALA_VERSION}/${MONGO_SPARK_CONNECTOR_VERSION}/mongo-spark-connector_${SCALA_VERSION}-${MONGO_SPARK_CONNECTOR_VERSION}.jar" -P "${SPARK_HOME}/jars/" && \
    apt-get purge -y --auto-remove wget && \
    rm -rf /var/lib/apt/lists/*

# Define the MongoDB Spark Connector version
ARG MONGO_SPARK_CONNECTOR_VERSION="10.3.0"
ARG SCALA_VERSION="2.12"

# Install the connector JAR into Spark's autoloader directory and clean up
RUN apt-get update && apt-get install -y --no-install-recommends wget && \
    wget "https://repo1.maven.org/maven2/org/mongodb/spark/mongo-spark-connector_${SCALA_VERSION}/${MONGO_SPARK_CONNECTOR_VERSION}/mongo-spark-connector_${SCALA_VERSION}-${MONGO_SPARK_CONNECTOR_VERSION}.jar" -P "${SPARK_HOME}/jars/" && \
    apt-get purge -y --auto-remove wget && \
    rm -rf /var/lib/apt/lists/*

# Define the MongoDB Spark Connector version
ARG MONGO_SPARK_CONNECTOR_VERSION="3.0.0"
ARG SCALA_VERSION="2.12"

# Install the connector JAR into Spark's autoloader directory and clean up
RUN apt-get update && apt-get install -y --no-install-recommends wget && \
    wget "https://repo1.maven.org/maven2/org/mongodb/spark/mongo-spark-connector_${SCALA_VERSION}/${MONGO_SPARK_CONNECTOR_VERSION}/mongo-spark-connector_${SCALA_VERSION}-${MONGO_SPARK_CONNECTOR_VERSION}.jar" -P "${SPARK_HOME}/jars/" && \
    apt-get purge -y --auto-remove wget && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends wget && \
    wget "https://repo1.maven.org/maven2/org/mongodb/mongodb-driver-sync/4.11.1/mongodb-driver-sync-4.11.1.jar" -P "${SPARK_HOME}/jars/" && \
    apt-get purge -y --auto-remove wget && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends wget && \
    wget "https://repo1.maven.org/maven2/org/mongodb/bson/4.11.1/bson-4.11.1.jar" -P "${SPARK_HOME}/jars/" && \
    apt-get purge -y --auto-remove wget && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends wget && \
    wget "https://repo1.maven.org/maven2/org/mongodb/mongodb-driver-core/4.11.1/mongodb-driver-core-4.11.1.jar" -P "${SPARK_HOME}/jars/" && \
    apt-get purge -y --auto-remove wget && \
    rm -rf /var/lib/apt/lists/*

# Switch back to the default notebook user
USER ${NB_USER}

# Install the requested Python packages using pip 🐍
RUN pip install --no-cache-dir sodapy pymongo