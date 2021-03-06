#!/bin/bash
# Unofficial Salesforce DX install script for Salesforce.org NonProfite Success Pack (NPSP)
# https://github.com/pozil/npsp-dx-template

# Salesforce DX scratch org alias
ORG_ALIAS="npsp-dev"

# Reset current path to be relative to script file
SCRIPT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd $SCRIPT_PATH

echo ""
echo "Installing org with alias: $ORG_ALIAS"
echo ""

echo "Cleaning previous scratch org..."
sfdx force:org:delete -p -u $ORG_ALIAS
echo ""

echo "Creating scratch org..." && \
sfdx force:org:create -s -f config/project-scratch-def.json -d 30 -a $ORG_ALIAS && \
echo "" && \

echo "Installing NPSP" && \
./build-scripts/install-npsp.sh $ORG_ALIAS && \
echo "" && \

# Uncomment this if you have local source code that you want to push
#echo "Pushing local DX sources..." && \
#sfdx force:source:push -u $ORG_ALIAS && \
#echo "" && \

# Get and check last exit code
echo ""
EXIT_CODE="$?"
if [ "$EXIT_CODE" -eq 0 ]; then
  echo "Installation completed."
else
    echo "Installation failed."
fi
exit $EXIT_CODE
