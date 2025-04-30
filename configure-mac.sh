#!/bin/bash

set -e

echo "🔧 Bootstrapping macOS for Ansible..."

# 1. Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "🍺 Homebrew already installed."
fi

# 2. Update Homebrew
brew update

# 3. Install Python (needed for Ansible)
if ! command -v python3 &> /dev/null; then
  echo "🐍 Installing Python..."
  brew install python
else
  echo "🐍 Python already installed."
fi

# 4. Install Ansible
if ! command -v ansible &> /dev/null; then
  echo "📦 Installing Ansible..."
  brew install ansible
else
  echo "📦 Ansible already installed."
fi

# 5. (Optional) Run your playbook if it exists
PLAYBOOK=playbook.yml
INVENTORY=inventory

if [[ -f "$PLAYBOOK" && -f "$INVENTORY" ]]; then
  echo "🚀 Running Ansible playbook..."
  ansible-playbook -i "$INVENTORY" "$PLAYBOOK"
else
  echo "ℹ️ No playbook.yml or inventory file found in current directory. Skipping Ansible run."
fi

echo "✅ Bootstrap complete!"
