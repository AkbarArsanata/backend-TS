# Use official lightweight Python image
FROM python:3.11-slim

# Set working directory inside the container
WORKDIR /app

# Install necessary system dependencies (if needed)
# Example for installing gcc if some packages require compilation:
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements.txt first to utilize Docker layer caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose port (this is optional on Railway since it uses dynamic PORT)
EXPOSE 8000

# Command to run the application using uvicorn
# Using environment variable $PORT for compatibility with Railway
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "${PORT}"]
