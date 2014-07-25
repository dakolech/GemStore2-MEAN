Product = require('../models/product')
Category = require('../models/category')
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
  console.log req.body.id
  req.pipe(req.busboy);
  filename1 = req.busboy.on('file',  (fieldname, file, filename, id) ->
      console.log("Uploading: " + filename); 
      fstream = fs.createWriteStream('./public/images/' + filename);
      file.pipe(fstream);
      name = filename
      console.log name
      fstream.on('close', ->

        
        return
      );
      return name
  );
  req.busboy.on('field', (key, value, keyTruncated, valueTruncated) ->
    console.log value + filename1
    Product.findByIdAndUpdate value,
    {$push: {images: filename1}},
    {safe: true, upsert: true}, (err, product) ->
      res.send(err) if (err)
      
      
      Product.find (err, products) ->
        res.send(err) if (err)            
        res.json(products)
        return
      return
  );
  ###
  req.busboy.on('file',  (fieldname, file, filename) ->
    console.log filename
    newPath = './public/images/' + filename
    thumbPath = './public/images/thumbs/' + filename
    galleryPath = './public/images/gallerySize/' + filename
    console.log galleryPath
    
    im.resize {
      srcPath: newPath,
      dstPath: thumbPath,
      height:   100 
    }, (err, stdout, stderr) ->
      throw err if (err)
      console.log('resized image to fit within 200x200px');
      return

    im.resize {
      srcPath: newPath,
      dstPath: galleryPath,
      height:   400 
    }, (err, stdout, stderr) ->
      throw err if (err)
      console.log('resized image to fit within 500x500px');
      return
    return
  );###
  return



  #console.log req.file
  #console.log req.files
  ###
  console.log("Added image ("+req.files.file.name+") to "+req.body.id)
  
  fs.readFile req.files.file.path, (err, data) ->

    imageName = req.files.file.name

    # If there's an error
    if !imageName
      console.log("There was an error")
      Product.find (err, products) ->
        res.send(err) if (err)            
        res.json(products);
        return

    else 

      newPath = './public/images/' + imageName
      thumbPath = './public/images/thumbs/' + imageName
      galleryPath = './public/images/gallerySize/' + imageName

      # write file to images folder
      fs.writeFile newPath, data, (err) ->
      #console.log(newPath,thumbPath);        
        im.resize {
          srcPath: newPath,
          dstPath: thumbPath,
          height:   100 
        }, (err, stdout, stderr) ->
          throw err if (err)
          console.log('resized image to fit within 200x200px');
          return

        im.resize {
          srcPath: newPath,
          dstPath: galleryPath,
          height:   400 
        }, (err, stdout, stderr) ->
          throw err if (err)
          console.log('resized image to fit within 500x500px');
          return

        return

      # let's see it
      #res.redirect("/images/" + imageName);
    return

  
  Product.findByIdAndUpdate req.body.id,
    {$push: {images: req.files.file.name}},
    {safe: true, upsert: true}, (err, product) ->
      res.send(err) if (err)
      
      
      Product.find (err, products) ->
        res.send(err) if (err)            
        res.json(products)
        return
      return
###
  #return