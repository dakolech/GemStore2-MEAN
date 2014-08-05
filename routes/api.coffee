Product = require('../models/product')
Category = require('../models/category')
Site = require('../models/site')
fs = require('fs')
im = require('imagemagick')
im.identify.path = '../identify.exe'
im.convert.path = '../convert.exe'
 
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

exports.productsCategory = (req, res) ->
  Product.find({ 'category': req.params.category }, (err, products) ->
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
    canPurchase : req.body.canPurchase,
    category : req.body.category
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

exports.editProduct = (req, res) ->
  console.log "Edit: " + req.params.id
  Product.update {
      _id : req.params.id
      }, {
      name : req.body.name,
      price : req.body.price,
      description : req.body.description,
      category: req.body.category
    }, { multi: false }, (err, product) ->
      if (err)
        res.send(err);
      return

  Product.findById(req.params.id, (err, product) ->
        res.send(err) if (err)
    
        res.json(product);
      );

exports.addReviewToProduct = (req, res) ->
  console.log('Review: '+req.body.stars+' stars, '+req.body.body+ ', by '+req.body.author+' added to: '+req.params.id);
  Product.findByIdAndUpdate req.params.id,
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

exports.categories = (req, res) ->
  Category.find((err, categories) ->
        res.send(err) if (err)

        res.json(categories)
      );


exports.addCategory = (req, res) ->
  console.log('Category created: '+req.body.name+' id: '+req.body.id)
  Category.create {
    name : req.body.name,
  }, (err, product) ->
    if (err)
      res.send(err);

    # get and return all the products after you create another
    Category.find (err, categories) ->
      if (err)
        res.send(err)
      res.json(categories);
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

exports.AddImage = (req, res) ->
  console.log "Image: " + req.params.id
  req.pipe(req.busboy);
  req.busboy.on('file',  (fieldname, file, filename, id) ->
      console.log("Uploading: " + filename); 
      fstream = fs.createWriteStream('./public/images/' + filename);
      file.pipe(fstream);
      name = filename
      console.log name
      fstream.on('close', ->

        Product.findByIdAndUpdate req.params.id,
        {$push: {images: filename}},
        {safe: true, upsert: true}, (err, product) ->
          res.send(err) if (err)
          
          
          Product.find (err, products) ->
            res.send(err) if (err)            
            res.json(products)
            return
          return
        
        return
      );
      return name
  );
  return

exports.deleteImage = (req, res) ->
  console.log "Image deleting: " + req.params.id+req.params.name
  Product.findByIdAndUpdate req.params.id,
        {$pull: {images: req.params.name}},
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


exports.sites = (req, res) ->
  Site.find((err, sites) ->
        res.send(err) if (err)

        res.json(sites)
      );

exports.addSite = (req, res) ->
  console.log('Category created: '+req.body.title+' id: '+req.body.id)
  Site.create {
    title   : req.body.title,
    content : req.body.content
  }, (err, product) ->
    if (err)
      res.send(err);

    # get and return all the products after you create another
    Site.find (err, sites) ->
      if (err)
        res.send(err)
      res.json(sites);
      return
    return
  return

exports.site = (req, res) ->
  Site.findOne({ 'title': req.params.title }, (err, site) ->
        res.send(err) if (err)
    
        res.json(site);
      );

exports.deleteSite = (req, res) ->
  Site.remove {
    _id : req.params.id
  }, (err, product) ->
    res.send(err) if (err)
      

    # get and return all the products after you create another
    Site.find (err, sites) ->
      res.send(err) if (err)            
      res.json(sites)
      return
    return
  return