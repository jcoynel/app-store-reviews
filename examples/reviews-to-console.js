// Copyright (c) 2013-2015 Jules Coynel
// https://github.com/jcoynel/app-store-reviews

var appStoreReviewsModule = require('app-store-reviews');
var appStoreReviews = new appStoreReviewsModule();

appStoreReviews.on('review', function(review) {
	console.log(review);
});

appStoreReviews.on('nextPage', function(nextPage) {
	appStoreReviews.getReviews(nextPage['appId'], nextPage['country'], nextPage['nextPage']);
});

appStoreReviews.getReviews('555731861', 'us', 1);