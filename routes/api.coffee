Product = require('../models/product')
fs = require('fs')
#im = require('imagemagick')
#im.identify.path = '../identify.exe'
#im.convert.path = '../convert.exe'
 
exports.name =  (req, res) ->
  res.json({
    name: 'Boby'
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

exports.addProduct = (req, res) ->
  console.log('Product created: '+req.body.name+', '+req.body.price+' id: '+req.body.id)
  Product.create {
    name : req.body.name,
    price : req.body.price,
    description : req.body.description,
    canPurchase : req.body.canPurchase
  }, (err, product) ->
    if (err)
      res.send(err);

    # get and return all the products after you create another
    Product.find (err, products) ->
      if (err)
        res.send(err)
      res.json(products);
      return
    return
  return

exports.addReviewToProduct = (req, res) ->
  console.log('Review: '+req.body.stars+' stars, '+req.body.body+ ', by '+req.body.author+' added to: '+req.body.id);
  Product.findByIdAndUpdate req.body.id,
    {$push: {reviews: {stars: req.body.stars, body: req.body.body, author: req.body.author}}},
    {safe: true, upsert: true}, (err, product) ->
      if (err)
        res.send(err);
        
      Product.find (err, products) ->
        if (err)
          res.send(err)
        res.json(products);
        return
      return
    
  return

exports.deleteProduct = (req, res) ->
  Product.remove {
    _id : req.params.id
  }, (err, product) ->
    res.send(err) if (err)
      

    # get and return all the products after you create another
    Product.find (err, products) ->
      res.send(err) if (err)            
      res.json(products)
      return
    return
  return

exports.image = (req, res) ->
  console.log(req.params.file)
  file = req.params.file
  img = fs.readFileSync("./public/images/" + file)
  res.writeHead(200, {'Content-Type': 'image/jpg' })
  res.end(img, 'binary')
  return