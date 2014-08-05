var mongoose = require('mongoose');

module.exports = mongoose.model('Site', {
	title 		: String,
	content 	: String,
	type 		: String,
	added		: { type: Date, default: Date.now },
	place 		: Number,
	isIndex		: { type: Boolean, default: false },
});