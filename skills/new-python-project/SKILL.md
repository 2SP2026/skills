---
name: new-python-project
description: Create a new Python project with standardized structure, Python 3.12 virtual environment, and essential configuration files
license: MIT
---

# New Python Project Creator

## Overview

This skill automates the creation of new Python projects in the Antigravity workspace with standardized structure and Python 3.12 virtual environments.

---

# Process

## 🚀 Quick Start

### Usage
Simply invoke this skill with a project name:
```
/new-python-project my_project_name
```

Or ask Claude to create a new Python project and mention the project name.

---

## 📋 What Gets Created

### Directory Structure
```
ll_[project_name]/
├── venv/                    # Python 3.12 virtual environment
├── main.py                  # Main entry point
├── requirements.txt         # Project dependencies
├── README.md               # Project documentation
├── .gitignore              # Git ignore patterns
└── tests/                  # Test directory (optional)
    └── __init__.py
```

### Standard Files

#### main.py
Basic executable Python script with:
- Shebang for direct execution
- Main function structure
- `if __name__ == "__main__"` guard

#### requirements.txt
Empty dependencies file ready for additions

#### README.md
Standard project documentation with:
- Project title and description
- Setup instructions
- Usage examples
- Virtual environment activation commands

#### .gitignore
Python-specific ignore patterns:
- Virtual environment directory
- Python cache files
- IDE configurations
- OS-specific files

---

## 🎯 Project Standards

### Naming Convention
All Python projects use the `ll_` prefix:
- `ll_project_name` format
- Lowercase with underscores
- Descriptive, concise names

Examples:
- `ll_data_processor`
- `ll_api_client`
- `ll_automation_tool`

### Python Version
- **Python 3.12.8** is the standard
- Workspace-level `.python-version` ensures consistency
- Virtual environments automatically use Python 3.12

### Virtual Environment
- Always created with `python3 -m venv venv`
- Located in project root as `venv/`
- Isolated dependencies per project
- Must be activated before installing packages

---

## 📝 Step-by-Step Creation Process

### 1. Create Project Directory
```bash
mkdir ll_[project_name]
cd ll_[project_name]
```

### 2. Create Virtual Environment
```bash
python3 -m venv venv
```
This creates a Python 3.12 virtual environment (due to workspace `.python-version`)

### 3. Create Standard Files
- `main.py` with basic structure
- `requirements.txt` (empty)
- `README.md` with setup instructions
- `.gitignore` with Python patterns

### 4. Set Executable Permission
```bash
chmod +x main.py
```

### 5. Verify Setup
```bash
source venv/bin/activate
python --version  # Should show Python 3.12.8
python main.py    # Test run
```

---

## 💡 Usage Examples

### Example 1: Simple Script
```
User: "Create a new Python project called ll_file_organizer"
Claude: Creates project with standard structure, ready for development
```

### Example 2: API Client
```
User: "I need a new Python project for a REST API client, call it ll_api_wrapper"
Claude: Creates project, suggests adding 'requests' to requirements.txt
```

### Example 3: Data Processing
```
User: "Create ll_data_pipeline for ETL workflows"
Claude: Creates project, suggests adding pandas, numpy to requirements
```

---

## ✅ Post-Creation Checklist

After creating a new project:

1. **Activate Virtual Environment**
   ```bash
   source venv/bin/activate
   ```

2. **Install Dependencies** (if needed)
   ```bash
   pip install -r requirements.txt
   ```

3. **Update README.md**
   - Add project-specific description
   - Document any special setup requirements
   - Add usage examples

4. **Add Dependencies**
   ```bash
   pip install [package_name]
   pip freeze > requirements.txt
   ```

5. **Initialize Git** (optional)
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   ```

---

## 🛠️ Best Practices

### Virtual Environment Management
- **Always activate** before installing packages
- **Never commit** the venv/ directory to git
- **Keep requirements.txt updated** after adding packages
- **Use pip freeze** to capture exact versions

### Dependency Management
```bash
# Add a new package
pip install package_name

# Update requirements.txt
pip freeze > requirements.txt

# Install from requirements.txt
pip install -r requirements.txt
```

### Project Organization
- Keep `main.py` simple, import from modules
- Use subdirectories for larger projects
- Add tests in `tests/` directory
- Document complex functions and classes

### Python 3.12 Specific
- Python 3.12 offers excellent stability
- Best package ecosystem compatibility
- Security updates through 2028
- No experimental features to worry about

---

## 🔧 Troubleshooting

### Wrong Python Version
**Problem:** Virtual environment uses wrong Python version

**Solution:**
```bash
# Check workspace Python version
cd /Users/leol/Desktop/Antigravity
cat .python-version  # Should show 3.12.8

# Verify current Python
python3 --version

# If wrong, check pyenv
pyenv local 3.12.8
```

### Virtual Environment Not Activating
**Problem:** `source venv/bin/activate` fails

**Solution:**
```bash
# Recreate virtual environment
rm -rf venv
python3 -m venv venv
source venv/bin/activate
```

### Package Installation Fails
**Problem:** `pip install` gives errors

**Solution:**
```bash
# Upgrade pip first
pip install --upgrade pip

# Then install packages
pip install -r requirements.txt
```

### Permission Denied on main.py
**Problem:** `./main.py` gives permission denied

**Solution:**
```bash
chmod +x main.py
./main.py
```

---

## 📚 Related Documentation

- See `PYTHON_VENV_BEST_PRACTICES.md` for detailed virtual environment guidance
- See `CREATING_EXECUTABLES.md` for making standalone executables
- Workspace `.python-version` controls Python version for all projects

---

## 🎓 When to Use This Skill

**Use this skill when:**
- Starting any new Python project
- Need standardized project structure
- Want Python 3.12 virtual environment automatically
- Creating tools, scripts, or applications

**Skip this skill when:**
- Adding to existing project
- Need custom project structure
- Working outside Antigravity workspace
- Using different Python version required

---

## Example Invocation

```
User: /new-python-project data_analyzer
```

Claude will:
1. Create `ll_data_analyzer/` directory
2. Set up Python 3.12 virtual environment
3. Create all standard files
4. Verify setup with test run
5. Report completion with next steps
