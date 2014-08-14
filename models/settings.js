var mongoose = require('mongoose');

module.exports = mongoose.model('Settings', {
	title 			: String,
	footer 			: String,
	indexTitle		: String,
	productsTitle	: String,
	description		: String
});