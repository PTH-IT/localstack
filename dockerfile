FROM python:3.8-slim-buster

# Set environment variables
ENV SERVICES=s3,lambda,dynamodb
ENV PORT_WEB_UI=8080

# Install required packages
RUN apt-get update && \
    apt-get install -y git unzip && \
    rm -rf /var/lib/apt/lists/*

# Clone LocalStack repository
RUN git clone --depth 1 --branch master https://github.com/localstack/localstack.git /opt/code/localstack

# Install LocalStack dependencies
WORKDIR /opt/code/localstack
RUN pip install -r requirements.txt

# Copy custom configurations
COPY config/localstack-config.json ./

# Expose required ports
EXPOSE 4566 4571 8080

# Start LocalStack
ENTRYPOINT ["localstack"]
CMD ["start"]