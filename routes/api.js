// Generated by CoffeeScript 1.7.1
var Product, fs;

Product = require('../models/product');

fs = require('fs');

exports.name = function(req, res) {
  res.json({
    name: 'Boby'
  });
};

exports.products = function(req, res) {
  return Product.find(function(err, products) {
    if (err) {
      res.send(err);
    }
    return res.json(products);
  });
};

exports.product = function(req, res) {
  return Product.findById(req.params.id, function(err, product) {
    if (err) {
      res.send(err);
    }
    return res.json(product);
  });
};

exports.addProduct = function(req, res) {
  console.log('Product created: ' + req.body.name + ', ' + req.body.price + ' id: ' + req.body.id);
  Product.create({
    name: req.body.name,
    price: req.body.price,
    description: req.body.description,
    canPurchase: req.body.canPurchase
  }, function(err, product) {
    if (err) {
      res.send(err);
    }
    Product.find(function(err, products) {
      if (err) {
        res.send(err);
      }
      res.json(products);
    });
  });
};

exports.deleteProduct = function(req, res) {
  Product.remove({
    _id: req.params.id
  }, function(err, product) {
    if (err) {
      res.send(err);
    }
    Product.find(function(err, products) {
      if (err) {
        res.send(err);
      }
      res.json(products);
    });
  });
};
