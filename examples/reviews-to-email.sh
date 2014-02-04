#!/bin/sh

cd /PATH/TO/app-store-reviews/EXAMPLES/
node reviews-to-mysql.js
node mysql-to-email.js
