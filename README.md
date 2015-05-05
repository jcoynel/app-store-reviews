## About app-store-reviews

[![NPM version](https://badge.fury.io/js/app-store-reviews.png)](http://badge.fury.io/js/app-store-reviews)

Node.js module to download user reviews from the iTunes Store and the Mac App Store.

It supports:

* All countries
* All apps on the iTunes Store
* All apps on the Mac App Store

This module uses the public feed to customer reviews

  http://itunes.apple.com/rss/customerreviews/page=1/id=555731861/sortby=mostrecent/json?l=en&cc=us

## Installation
app-store-reviews is available via the npm packet manager.

```bash
$ npm install app-store-reviews
```

## Usage
You can find all the following examples in the [examples](https://raw.github.com/jcoynel/app-store-reviews/master/examples/) folder.

### Example 1: single app and country
In this example we simply print the reviews of [Tunes Notifier](http://www.tunes-notifier.com) to the console from the **US Store**. The ID of the app is **555731861**.

#### Code
```js
var appStoreReviewsModule = require('app-store-reviews');
var appStoreReviews = new appStoreReviewsModule();

appStoreReviews.on('review', function(review) {
	console.log(review);
});

appStoreReviews.getReviews('555731861', 'us', 1);
```

#### Output
```bash
[ id: '676984080',
  app: '555731861',
  author: 'appwatching',
  version: '1.1',
  rate: '5',
  title: 'Very good',
  comment: 'Mucho mejor ahora. Ya se puede esconder el icono de la barra de menús.',
  vote: '0',
  country: 'us' ]
```

### Example 2: import to a database for all countries
In this example we store the reviews in a MySQL database.

You can find the structure of the database in [examples/reviews-to-mysql.sql](https://raw.github.com/jcoynel/app-store-reviews/master/examples/reviews-to-mysql.sql)

#### Code
```js
var appStoreReviewsModule = require('app-store-reviews');
var appStoreReviews = new appStoreReviewsModule();

var mysql = require('mysql');

function mysqlConnection()
{
  var db = mysql.createConnection ({
		user : 'root',
	    password : 'root',
	    host : "localhost",
	    database : "reviews",
	    port : "3306"
	});

	return db;
}

function insertReviewInDb(id, app, author, version, rate, title, comment, country)
{
	var review = {
		id: id,
		app: app,
		author: author,
		version: version,
		rate: rate,
		title: title,
		comment: comment,
		country: country
	}

	var db = mysqlConnection();
	db.connect();
	db.query('INSERT IGNORE INTO reviews SET ?', review);
	db.end();
}

appStoreReviews.on('review', function(review) {
	insertReviewInDb(review['id'], review['app'], review['author'], review['version'], review['rate'], review['title'], review['comment'], review['country']);
});

appStoreReviews.on('nextPage', function(nextPage) {
	appStoreReviews.getReviews(nextPage['appId'], nextPage['country'], nextPage['nextPage']);
});


console.log("Starting reviews-to-mysql.js at " + Date());
var db = mysqlConnection();
db.connect();
db.query('SELECT * FROM apps WHERE enabled=1', function(err, rows, fields) {
	if (err) {
		console.log("DB error: " + err);
	} else {
		for (var index in rows) {
			console.log("App: " + rows[index].id + " - " + rows[index].name);
			
			var countries;
			if (rows[index].countries == null || rows[index].countries == "") {
				countries = appStoreReviews.allCountries();
			} else {
				countries = rows[index].countries.split(',');
				console.log(countries);
			}
			
			for (var countryIndex in countries) {
				appStoreReviews.getReviews(rows[index].id, countries[countryIndex], 1);
			}
		}
	}
});
db.end();
```

### Example 3: automatically email new reviews
In this example we store the reviews in a MySQL database and send the new reviews by email periodically using Cron.

You can find the structure of the database in [examples/reviews-to-mysql.sql](https://raw.github.com/jcoynel/app-store-reviews/master/examples/reviews-to-mysql.sql).

* In a directory, copy the following files
 * [examples/reviews-to-mysql.js](https://raw.github.com/jcoynel/app-store-reviews/master/examples/reviews-to-mysql.js)
 * [examples/mysql-to-email.js](https://raw.github.com/jcoynel/app-store-reviews/master/examples/mysql-to-email.js)
 * [examples/reviews-to-email.sh](https://raw.github.com/jcoynel/app-store-reviews/master/examples/reviews-to-email.sh)

* Install the required Node.js modules
```bash
$ npm install app-store-reviews
$ npm install mysql
$ npm install nodemailer
```

* In **reviews-to-mysql.js**, configure your database connection details.

* In **mysql-to-email.js**, configure your database connection details and email address and password.

* In **reviews-to-email.sh**, set the path to the directory containing this file.

* Make **reviews-to-email.sh** executable: `chmod +x reviews-to-email.sh`

* Add **reviews-to-email.sh** to Cron
 * Edit the current crontab: `$ crontab -e`
 * Add the following line (run every day at 12): `0 12 * * * /EXAMPLE/PATH/reviews-to-email.sh`
 

## Licence (MIT)

Copyright (c) 2013-2015 Jules Coynel

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
