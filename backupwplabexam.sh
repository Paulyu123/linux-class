#!/bin/bash
echo "#############################"
echo "# BACKING UP MYSQL DATABESE #"
echo "#############################"
v1=paulyupogi
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
mysqldump -u root -p$v1 wordpress > wordpressbak.sql
echo "#############################"
echo "# BACKING UP MYSQL DATABESE #"
echo "#         COMPLETED         #"
echo "#############################"
