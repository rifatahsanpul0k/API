# Use an official Python runtime as a parent image
FROM python:3.7-alpine

# The maintainer of the image
LABEL maintainer="Pulok <pulok.github@gmail.com>"

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Copy the requirements file to the image
COPY requirements.txt /app/requirements.txt

# Change working directory
WORKDIR /app

# Install dependencies
RUN pip install -r requirements.txt

# Copy the rest of the application code
COPY . /app

# Create a user and switch to it
RUN adduser -D user
USER user

# Define the command to run the application
CMD ["sh", "-c", "python manage.py test && flake8"]
