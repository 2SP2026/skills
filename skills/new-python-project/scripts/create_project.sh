#!/bin/bash
# Create a new Python project with standardized structure
# Usage: ./create_project.sh <project_name>

set -e

# Check if project name provided
if [ -z "$1" ]; then
    echo "Error: Project name required"
    echo "Usage: ./create_project.sh <project_name>"
    exit 1
fi

PROJECT_NAME="$1"
PROJECT_DIR="ll_${PROJECT_NAME}"
WORKSPACE_DIR="/Users/leol/Desktop/Antigravity"

# Navigate to workspace
cd "$WORKSPACE_DIR"

# Check if project already exists
if [ -d "$PROJECT_DIR" ]; then
    echo "Error: Project '$PROJECT_DIR' already exists"
    exit 1
fi

echo "Creating new Python project: $PROJECT_DIR"

# Create project directory
mkdir "$PROJECT_DIR"
cd "$PROJECT_DIR"

# Create virtual environment
echo "Creating Python 3.12 virtual environment..."
python3 -m venv venv

# Create main.py
cat > main.py << 'EOF'
#!/usr/bin/env python3
"""
Main entry point for the project
"""

def main():
    print("Hello from the project!")

if __name__ == "__main__":
    main()
EOF

chmod +x main.py

# Create requirements.txt
cat > requirements.txt << 'EOF'
# Project dependencies
# Add your packages here
EOF

# Create .gitignore
cat > .gitignore << 'EOF'
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# Virtual Environment
venv/
.venv/
ENV/
env/

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Testing
.pytest_cache/
.coverage
htmlcov/
EOF

# Create README.md
cat > README.md << EOF
# $PROJECT_DIR

Python project created with standardized structure.

## Setup

\`\`\`bash
# Activate virtual environment
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
\`\`\`

## Usage

\`\`\`bash
python main.py
\`\`\`

## Python Version

This project uses Python 3.12.8 as configured in the Antigravity workspace.
EOF

echo "✅ Project created successfully!"
echo ""
echo "Next steps:"
echo "  cd $PROJECT_DIR"
echo "  source venv/bin/activate"
echo "  python main.py"
