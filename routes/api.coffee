Product = require('../models/product')
fs = require('fs')
#im = require('imagemagick')
#im.identify.path = '../identify.exe'
#im.convert.path = '../convert.exe'
 
exports.name =  (req, res) ->
  res.json({
    name: 'Bob'
  });
  return


exports.products = (req, res) ->
	Product.find((err, products) ->
        res.send(err) if (err)

        res.json(products)
      );


exports.product = (req, res) ->
	Product.findById(req.params.id, (err, product) ->
        res.send(err) if (err)
		
        res.json(product);
      );
