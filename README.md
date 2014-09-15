Close Issues
============

This is a simple bash script to close issues on FORGE Service Lab's Redmine.

Usage
-----

`./close_issues.sh -u username 1234 1235`

The script will prompt for the user's password and close the specified issue numbers with a default message.
If the issue numbers to close are a sequential list, the script can be called as follows:

`./close_issues.sh -u username $(seq 1234 1256)`

This will close all issues between and including 1234 and 1256.
