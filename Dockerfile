# Use a slim Python image for efficiency
FROM python:3.13-slim

# Set environment variables
#prevent writing of .pyc files in __pycache__
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies (needed for PostgreSQL/SQLAlchemy and XGBoost)
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the project files
COPY . .

# Default command (can be overridden in docker-compose)
CMD ["python", "main.py"]