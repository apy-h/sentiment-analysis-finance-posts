#!/bin/bash
# Render deployment start script
# This script configures production settings for Render deployment

# Exit on error
set -e

# Change to backend directory
cd backend

# Install dependencies (Render typically does this, but included for safety)
pip install -r requirements.txt

# Run database migrations
echo "Running database migrations..."
python3 migrations.py

# Set production environment variables
export FLASK_DEBUG=false
export FLASK_ENV=production

# Get the PORT from Render (defaults to 5000 if not set)
PORT=${PORT:-5000}

# Start the app with gunicorn (production WSGI server)
# 4 workers, bind to 0.0.0.0 on the Render-provided PORT
echo "Starting Flask app on port $PORT..."
gunicorn -w 4 -b 0.0.0.0:$PORT app:app
