// Copyright (c) 2013-2015 Jules Coynel
// https://github.com/jcoynel/app-store-reviews

/*
Node.js modules required
	- app-store-reviews
	- mysql
*/

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