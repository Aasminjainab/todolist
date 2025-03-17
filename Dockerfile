# Use official Python image as the base
FROM python:3.9-slim

# Install required system dependencies
RUN apt update && apt install -y \
    gcc \
    g++ \
    libpq-dev \
    libmariadb-dev \
    python3-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy requirements.txt first to leverage Docker cache
COPY requirements.txt .

# Install dependencies
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the application port (Django runs on 8000 by default)
EXPOSE 8000

# Run database migrations and collect static files
RUN python manage.py migrate && python manage.py collectstatic --noinput

# Command to start the Django app
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
