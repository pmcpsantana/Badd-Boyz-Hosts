#!/bin/bash
# ********************
# Run Funceble Testing
# ********************

# Created by: Mitchell Krog (mitchellkrog@gmail.com)
# Copyright: Mitchell Krog - https://github.com/mitchellkrogza
# Repo Url: https://github.com/mitchellkrogza/The-Big-List-of-Hacked-Malware-Web-Sites

# ****************************************************************
# This uses the awesome PyFunceble script created by Nissar Chababy
# Find funceble at: https://github.com/funilrys/PyFunceble
# ****************************************************************

# ******************
# Set our Input File
# ******************
_input=$TRAVIS_BUILD_DIR/PULL_REQUESTS/domains.txt

# ******************************************
# Make Sure Travis Own all files and Folders
# ******************************************

sudo chown -R travis:travis $TRAVIS_BUILD_DIR/

# *******************************
# Set Funceble Scripts Executable
# *******************************

sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/PyFunceble/PyFunceble.py

# ****************************
# Switch to funceble directory
# ****************************

cd $TRAVIS_BUILD_DIR/.dev-tools/PyFunceble/

# ************************
# Settings date variables
# ************************

YEAR=$(date +%Y)
MONTH=$(date +%m)

# *****************************************************
# Exporting all variable that are needed by PyFunceble
# *****************************************************

export TRAVIS_BUILD_DIR=${TRAVIS_BUILD_DIR}
export GH_TOKEN=${GH_TOKEN}
export TRAVIS_REPO_SLUG=${TRAVIS_REPO_SLUG}
export GIT_EMAIL=${GIT_EMAIL}
export GIT_NAME=${GIT_NAME}

# ******************************************************************************
# Updating PyFunceble && Run PyFunceble
# Note: We use the same statement so that if something is broken everything else
#   is not run.
# ******************************************************************************
  sudo python3 ${TRAVIS_BUILD_DIR}/.dev-tools/PyFunceble/PyFunceble.py --dev -u && \
  mv ${TRAVIS_BUILD_DIR}/.dev-tools/PyFunceble/config_production.yaml ${TRAVIS_BUILD_DIR}/.dev-tools/PyFunceble/config.yaml && \
  sudo python3 ${TRAVIS_BUILD_DIR}/.dev-tools/PyFunceble/PyFunceble.py --travis -dbr 5 --cmd-before-end "bash ${TRAVIS_BUILD_DIR}/.dev-tools/final-commit.sh" -a -ex --plain --split --share-logs --autosave-minutes 10 --commit-autosave-message "V1.${YEAR}.${MONTH}.${TRAVIS_BUILD_NUMBER} [PyFunceble]" --commit-results-message "V1.${YEAR}.${MONTH}.${TRAVIS_BUILD_NUMBER}" -f $_input

exit ${?}
