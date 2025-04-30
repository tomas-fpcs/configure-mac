# configure-mac

Bootstrap with Ansible to configure and install apps on your Mac

## Usage 

```
./configure-mac.sh  
```

This script will bootstrap by installing:
- Homebrew
- Python
- Ansible

Once bootstrapped it will execute the Ansible playbook.
The provided [playbook.xml](playbook.xml) is for my preferences, but its simple to change.

To generate YAML for what you already have installed you can run this script. The output goes under "vars" in the playbook.

```
#generate-macos-ansible-yaml.sh

#!/bin/bash

echo "# Ansible-compatible YAML output for your macOS setup"
echo
echo "brews:"
brew list --formula | sort | sed 's/^/  - /'

echo
echo "casks:"
brew list --cask | sort | sed 's/^/  - /'

echo
if command -v mas &> /dev/null; then
  echo "mas_apps:"
  mas list | awk '{printf "  - %s  # %s\n", $1, substr($0, index($0,$2))}'
else
  echo "# mas (Mac App Store CLI) not installed. Run 'brew install mas' to enable."
  echo "mas_apps: []"
fi

```