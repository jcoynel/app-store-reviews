// Copyright (c) 2013-2015 Jules Coynel
// https://github.com/jcoynel/app-store-reviews

/*
Node.js modules required
	- app-store-reviews
	- mysql
*/

var appStoreReviewsModule = require('../lib/app-store-reviews');
var appStoreReviews = new appStoreReviewsModule();

appStoreReviews.on('done', function(data) {
  console.log("Retrieved reviews for pages", data["currentPage"],"of", data["lastPage"]);
  console.log("DONE", data);
});

appStoreReviews.on('nextPage', function(nextPage) {
   console.log("Retrieved reviews for pages", nextPage["currentPage"],"of", nextPage["lastPage"]);
	 appStoreReviews.getReviews(nextPage['appId'], nextPage['country'], nextPage['nextPage']);
});


console.log("Starting reviews-done-event.js at " + Date());

// Parameters: appid, country, page
appStoreReviews.getReviews("1111710488", "us", 1);
