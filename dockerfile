# 1. Base image with Python
FROM python:3.11-slim

# 2. Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# 3. Set work directory
WORKDIR /app

# 4. Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# 5. Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# 6. Copy the Django project
COPY . .

# 7. Expose the port the app runs on (Django default is 8000)
EXPOSE 8000

# 8. Run Django app (you can change this for production setups like gunicorn)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
