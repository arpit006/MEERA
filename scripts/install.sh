#!/bin/bash

echo Installing MEERA...
echo

echo Checking Requirements...
echo python: `python3.6 --version 2>&1`
echo pip: `pip --version`
echo

echo Installing virtualenv...
pip install virtualenv
echo

echo virtualenv: `virtualenv --version`
echo

PYTHON_BINARY=($(which python3.6))

echo $PYTHON_BINARY

echo Creating Virtual Environment...
echo pwd: `pwd`
virtualenv -p $PYTHON_BINARY venv
echo

echo Activating Virtual Environment...
source venv/bin/activate
echo Virtual Environment Activated.
echo

echo Installing Dependencies...
pip install -r requirements.txt
echo

echo Creating nlp/models Directory...
mkdir ./src/nlp/models
echo

echo Creating log Directory
mkdir log
chmod +w log
echo

echo Creating download Directory
mkdir download
chmod +w download
echo

echo Deactivating Virtual Environment...
deactivate
echo

echo Excluding .env file from git tracking...
git update-index --assume-unchanged .env
echo

if [ `id -u` == "0" ]; then
	cp ./scripts/autocomplete.sh /etc/bash_completion.d/meera.sh
	source ~/.bashrc
	echo "Configured autocomplete."
	echo
else
	echo Skipping autocomplete installation: `whoami` is not root.
	echo
fi

echo Installation Complete.
echo
