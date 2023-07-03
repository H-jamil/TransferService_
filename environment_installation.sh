#!/bin/bash

# Check if the correct number of arguments are passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <env_name> <python_version>"
    exit 1
fi

# Assign variables from arguments
env_name="$1"
python_version="$2"

# Install pyenv
if ! command -v pyenv &> /dev/null
then
    curl https://pyenv.run | bash
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc
    source ~/.bashrc
fi

# Install pyenv-virtualenv
if [ ! -d "$(pyenv root)/plugins/pyenv-virtualenv" ]; then
    git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
    source ~/.bashrc
fi

# Install the requested Python version
if ! pyenv versions --bare | grep -q "$python_version"
then
    pyenv install "$python_version"
fi

# Create a new virtual environment
if ! pyenv virtualenvs --bare | grep -q "$env_name"
then
    pyenv virtualenv "$python_version" "$env_name"
fi

echo "Python environment '$env_name' is ready to use. Activate it using 'pyenv activate $env_name'"
