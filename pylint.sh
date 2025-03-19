#!/bin/bash

# Enforce strict error handling
set -euxo pipefail  

# Define variables
APP_DIR="/home/ubuntu/jenkins/jenkins/workspace/todo-list_main"  # Correct path
PYTHON_BIN="/usr/bin/python3"
APP_FILE="manage.py"  # Update if your main Python file is different

# Ensure the application directory exists
if [ ! -d "$APP_DIR" ]; then
    echo "❌ Error: Directory $APP_DIR does not exist!"
    exit 1
fi

# Navigate to the application directory
cd "$APP_DIR"

# Start the application
echo "🚀 Starting application..."
nohup $PYTHON_BIN "$APP_FILE" runserver 0.0.0.0:8000 > app.log 2>&1 &

echo "✅ Deployment successful!"
