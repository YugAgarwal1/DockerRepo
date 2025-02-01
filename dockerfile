# Use Ubuntu as the base image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    gcc \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /LKH-3

# Download and extract LKH-3
RUN wget http://webhotel4.ruc.dk/~keld/research/LKH-3/LKH-3.0.13.tgz && \
    tar -xvzf LKH-3.0.13.tgz && \
    rm LKH-3.0.13.tgz

# Build LKH-3
WORKDIR /LKH-3/LKH-3.0.13
RUN make

# Install FastAPI and Uvicorn
RUN pip3 install fastapi uvicorn

# Copy API script
COPY app.py /LKH-3/LKH-3.0.13/app.py

# Expose port
EXPOSE 8000

# Run the API server
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
