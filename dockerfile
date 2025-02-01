# Use a minimal Linux base image
FROM ubuntu:latest

# Install dependencies including GCC, Make, and Wget
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /LKH-3

# Download and extract LKH-3.0.13
RUN wget http://webhotel4.ruc.dk/~keld/research/LKH-3/LKH-3.0.13.tgz && \
    tar -xvzf LKH-3.0.13.tgz && \
    rm LKH-3.0.13.tgz

# Build LKH-3
WORKDIR /LKH-3/LKH-3.0.13
RUN make

# Set LKH-3 as the default command
ENTRYPOINT ["/LKH-3/LKH-3.0.13/LKH"]