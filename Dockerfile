FROM python:3.9-slim-buster

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

ARG KEY_JSON
ENV KEY_JSON=$KEY_JSON

# Expose the port
EXPOSE 8080

# Start the application
CMD "gunicorn", "--bind", "0.0.0.0:8080", "main:app"
