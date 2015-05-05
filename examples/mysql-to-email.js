// Copyright (c) 2013-2015 Jules Coynel
// https://github.com/jcoynel/app-store-reviews

/*
Node.js modules required
	- app-store-reviews
	- mysql
	- nodemailer

You must configure the following
	- database in getMysqlConnection()
	- email in sendEmail()
*/

console.log("Starting mysql-to-email.js at " + Date());

var appStoreReviewsModule = require('app-store-reviews');
var appStoreReviews = new appStoreReviewsModule();

var nodemailer = require("nodemailer");

var mysql = require('mysql');

function getMysqlConnection()
{
	var db = mysql.createConnection ({
		user : '',
	    password : '',
	    host : 'localhost',
	    database : '',
	    port : "3306"
	});

	return db;
}

var db = getMysqlConnection();
db.connect();
db.query('SELECT * FROM apps', function (appsError, apps) {
	if (appsError) {
		console.log(appsError);
	} else {
		for (var appIndex = 0; appIndex < apps.length; appIndex++) {
			processAppComments(apps[appIndex]);
		}
	}
	db.end();
});

function processAppComments(app)
{
	var db1 = getMysqlConnection();
	db1.connect();
	db1.query('SELECT * FROM comments WHERE app_id = ? ORDER BY country ASC, rate DESC', app.id, function (commentsError, reviews) {
		if (commentsError) {
			console.log(commentsError);
		} else {
			console.log("Found " + reviews.length + " new review(s) for " + app.name);
			if (reviews.length > 0) {
				var db2 = getMysqlConnection();
				db2.connect();
				db2.query('SELECT COUNT(*) count, rate FROM comments WHERE app_id = ? GROUP BY rate ORDER BY rate DESC', app.id, function(error, rows) {
					var totalCount = 0;
					var totalRateByCount = 0;

					var rate1Count = 0;
					var rate2Count = 0;
					var rate3Count = 0;
					var rate4Count = 0;
					var rate5Count = 0;
										
					for (var index = 0; index < rows.length; index++) {
						var row = rows[index];
						totalCount += row.count;
						totalRateByCount += row.count * row.rate;
						
						switch (row.rate)
						{
							case 1:
								rate1Count = row.count;
								break;
							case 2:
								rate2Count = row.count;
								break;
							case 3:
								rate3Count = row.count;
								break;
							case 4:
								rate4Count = row.count;
								break;
							case 5:
								rate5Count = row.count;
								break;
						}
					}
					
					var text = '------------------------------\n';
					text += 'Summary\n';
					text += '------------------------------\n\n';
					text += '5 stars x ' + rate5Count + '\n';
					text += '4 stars x ' + rate4Count + '\n';
					text += '3 stars x ' + rate3Count + '\n';
					text += '2 stars x ' + rate2Count + '\n';
					text += '1 stars x ' + rate1Count + '\n';
					text += '\n';
					text += 'Average: ' + Math.round((totalRateByCount/totalCount) * 100) / 100 + ' stars\n\n';
										
					var lastCountryName = "";
					for (var i = 0; i < reviews.length; i++) {
						var review = reviews[i];
						var stars = reviews[i].rate;
						if (lastCountryName != review['country']) {
							lastCountryName = review['country'];
							text += '------------------------------\n';
							text += review['country'] + '\n';
							text += '------------------------------\n';
						}
						text += '***\n';
						text += stars + ' stars (v' + review.version + ') - by ' + review.author + '\n';
						text += review.title + '\n';
						text += review.comment + '\n';
						text += '\n';
					}
					
					text += '\n';
					text += '------------------------------\n';
					text += app.app_store_url + '\n';
										
					sendEmail(app.name, text);
					markReviewsAsEmailed(reviews);					
				});
				db2.end();
			}
		}
	});
	db1.end();
}

function sendEmail(appName, body)
{
	var smtpTransport = nodemailer.createTransport("SMTP",{
	   service: "Gmail",
	   auth: {
	       user: "",
	       pass: ""
	   }
	});

	smtpTransport.sendMail({
		from: "from.email@domain.com",
		to: "to.email@domain.com",
		subject: "New reviews for " + appName,
		text: body,
		}, function(error, response) {
			if (error) {
				console.log(error);
			} else {
				console.log("Sending email for " + appName + " at " + Date() + " with response \n", response);
			}
			
			smtpTransport.close();
	});
}

function markReviewsAsEmailed(reviews)
{
	var db = getMysqlConnection();
	db.connect();
	for (var i = 0; i < reviews.length; i++) {
		var review = reviews[i];
		db.query("UPDATE reviews SET emailed=1 WHERE id=?", review.review_id, function (error) {
			if (error) {
				console.log(error);
			}
		});
	}
	db.end();
}
