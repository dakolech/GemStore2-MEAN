/*
 * Serve JSON to our AngularJS client
 */

Product = require('../models/product')
fs = require('fs')
//im = require('imagemagick')
//im.identify.path = '../identify.exe'
//im.convert.path = '../convert.exe'
 
exports.name = function (req, res) {
  res.json({
    name: 'Bob'
  });
};

exports.products = function (req, res) {
	Product.find(function(err, products) {
        if (err) {
          res.send(err);
        }
        res.json(products);
      });
};

exports.product = function (req, res) {
	Product.findById(req.params.id, function(err, product) {
        if (err) {
          res.send(err);
        }
        res.json(product);
      });
};