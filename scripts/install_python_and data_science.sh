#!/bin/bash

#####################################################################################
# UPDATE #
echo "------ SETUP data science dependencies ------"
sudo apt-get -y update >/dev/null 2>&1

#####################################################################################
# INSTALLING FUNCTIONS #
# To reduce verbosity
function apt_install {
    for p in $@; do
        echo "installing $p"
        sudo apt-get -y install $p >/dev/null 2>&1
    done
}

function pip_install {
    for p in $@; do
        echo "installing $p"
        sudo pip install $p >/dev/null 2>&1
    done
}

#####################################################################################
# MODULES #

# Basics dependencies
apt_install python3-pip libpq-dev build-essential python-setuptools python-dev
apt_install g++ git libatlas3gf-base libatlas-dev cython unixodbc unixodbc-dev

# Data Engineering and Science
# ------------------------------------------------------------------------------
pip_install numpy pandas geopandas xlrd

# jupyter notebook
# ------------------------------------------------------------------------------
pip_install ipython jupyter

# Testing
# ------------------------------------------------------------------------------
pip_install pytest  # https://github.com/pytest-dev/pytest
pip_install pytest-sugar  # https://github.com/Frozenball/pytest-sugar
pip_install pytest-mock # https://github.com/pytest-dev/pytest-mock/
pip_install pytest-cov # https://pypi.org/project/pytest-cov/

# Code quality
# ------------------------------------------------------------------------------
pip_install flake8
pip_install isort
pip_install pylint # Linter.
pip_install pylint2junit # Used to generate junit xml reports in azure pipelines https://pypi.org/project/pylint2junit/
pip_install black # Auto formatter.
pip_install autoflake # Automatically removes unused imports and unused variables. See https://github.com/myint/autoflake
pip_install coverage  # https://github.com/nedbat/coveragepy
pip_install mypy  # https://github.com/python/mypy
pip_install bandit # Bandit is a tool designed to find common security issues in Python code. See https://pypi.org/project/bandit/

# Documentation
# ------------------------------------------------------------------------------
pip_install Sphinx
pip_install sphinx_rtd_theme # Documentation theme
pip_install recommonmark # Documentation using Markdown
pip_install sphinx-autobuild # Auto build and live reload server
pip_install doc8 # Doc8 is an opinionated style checker for rst (with basic support for plain text) styles of documentation. See https://github.com/openstack/doc8
# m2r # M2R converts a markdown file including reStructuredText (rst) markups to a valid rst format. See https://pypi.org/project/m2r/
# sphinxcontrib-blockdiag # Creates diagram images from simple text files. See http://blockdiag.com/en/index.html
# sphinxcontrib.actdiag # Creates diagram images from simple text files. See http://blockdiag.com/en/actdiag/index.html
# nbsphinx # Enables you to write your documentation in Jupyter Notebooks. See https://nbsphinx.readthedocs.io/en/0.4.2/

# Scraping
pip_install requests Scrapy bs4 feedparser

# Web framework
# pip_install flask
pip_install streamlit

# Scipy
pip_install scipy

# NLP
pip_install nltk

# Visualization
pip_install matplotlib seaborn bokeh Pillow Altair pydot graphviz bokeh hvplot panel pydeck

# DB connection
pip_install psycopg2 pymongo pyodbc pymysql

# Scikit-learn
pip_install scikit-learn

# Theano
pip_install theano

# Keras
pip_install keras

# tensorflow
pip_install tensorflow

# opencv
pip_install opencv-python

# Others
pip_install spacy vaderSentiment
pip_install PyYAML pipenv
pip_install python-docx lxml docformatter
pip_install sportsreference plotly yfinance twine yahooquery
pip_install autopep8 docformatter pycodestyle yapf pyformat

# clean packages.
apt-get -y autoremove --purge
apt-get -y clean

echo '------ SETUP data science dependencies FINISHED! ------'
#####################################################################################