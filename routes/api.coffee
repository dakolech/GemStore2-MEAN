Product   = require('../models/product')
Category  = require('../models/category')
Site      = require('../models/site')
Settings  = require('../models/settings')
User      = require('../models/user')
fs = require('fs')
easyimg = require('easyimage')

 
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
  }, (err, category) ->
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

exports.category = (req, res) ->
  Category.findById(req.params.id, (err, category) ->
        res.send(err) if (err)
    
        res.json(category);
      );

exports.editCategory = (req, res) ->
  console.log "Edit Category: " + req.params.id
  Category.update {
      _id : req.params.id
      }, {
      name : req.body.name
    }, { multi: false }, (err, category) ->
      if (err)
        res.send(err);
      return

  Category.findById(req.params.id, (err, category) ->
        res.send(err) if (err)

        console.log req.body.name+req.params.oldname
        Product.update {
              category: req.params.oldname
              }, {
              category: req.body.name
            }, { multi: true }, (err, product) ->
              if (err)
                res.send(err); 
              return

        res.json(category);
      );

exports.deleteCategory = (req, res) ->
  Product.remove {
    category : req.params.name
  }, (err, product) ->
    res.send(err) if (err)  

  Category.remove {
    _id : req.params.id
  }, (err, category) ->
    res.send(err) if (err)
      
    Category.find (err, categories) ->
      res.send(err) if (err)            
      res.json(categories)
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

        easyimg.resize({
             src: './public/images/' + filename,
             dst: './public/images/gallerySize/' + filename,
             width: 400, 
             height: 280,
          }).then(
          (image) ->
             console.log('Resized: ' + image.width + ' x ' + image.height);
          ,
          (err) ->
            console.log(err) 
        );


        easyimg.rescrop({
             src: './public/images/' + filename,
             dst: './public/images/thumbs/' + filename,
             width:100, 
             height:100,
             gravity: "Center"
          }).then(
          (image) ->
             console.log('Resized and cropped: ' + image.width + ' x ' + image.height);
          ,
          (err) ->
            console.log(err) 
        );

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
  Site.find({}).sort({place: 1}).execFind (err, sites) ->
        res.send(err) if (err)

        res.json(sites)


exports.addSite = (req, res) ->
  console.log('Category created: '+req.body.title+' id: '+req.body.id)
  Site.create {
    title   : req.body.title,
    content : req.body.content
  }, (err, product) ->
    if (err)
      res.send(err);

    # get and return all the products after you create another
   Site.find({}).sort({place: 1}).execFind (err, sites) ->
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
  return

exports.editSite = (req, res) ->
  console.log "Edit Site: " + req.params.id
  Site.update {
      _id : req.params.id
      }, {
      title   : req.body.title,
      content : req.body.content
    }, { multi: false }, (err, site) ->
      if (err)
        res.send(err);
      return

  Site.findOne({ '_id': req.params.id }, (err, site) ->
    res.send(err) if (err)

    res.json(site);
  );
  return

exports.deleteSite = (req, res) ->
  Site.remove {
    _id : req.params.id
  }, (err, product) ->
    res.send(err) if (err)
      

    # get and return all the products after you create another
    Site.find({}).sort({place: 1}).execFind (err, sites) ->
      res.send(err) if (err)            
      res.json(sites)
      return
    return
  return

exports.orderSite = (req, res) ->
  console.log "Edit order Site: " + req.body

  for i in [0..req.body.length-1] by 1
    Site.update {
        _id : req.body[i]
        }, {
        place   : i
      }, { multi: false }, (err, site) ->
        if (err)
          res.send(err);
        return

  Site.find({}).sort({place: 1}).execFind (err, sites) ->
    res.send(err) if (err)
    res.json(sites)
  return


exports.settings = (req, res) ->
  Settings.findOne({ '_id': '53ecbac2c7462a781f000002'}, (err, settings) ->
    res.send(err) if (err)

    res.json(settings)
  );

  return

exports.editSettings = (req, res) ->
  console.log "Edit settings"
  Settings.update {
      '_id' : '53ecbac2c7462a781f000002'
      }, {
      'title'       : req.body.title,
      'footer'      : req.body.footer,
      'indexTitle'  : req.body.indexTitle,
      'productsTitle' : req.body.productsTitle,
      'description' : req.body.description
    }, { multi: false }, (err, settings) ->
      if (err)
        res.send(err);
      return

  Settings.findOne({ '_id': '53ecbac2c7462a781f000002' }, (err, settings) ->
    res.send(err) if (err)

    res.json(settings);
  );
  return

exports.addSettings = (req, res) ->
  console.log 'Settings created'
  Settings.create {
    title         : req.body.title,
    footer        : req.body.footer,
    indexTitle    : req.body.indexTitle,
    productsTitle : req.body.productsTitle,
    description   : req.body.description
  }, (err, product) ->
    if (err)
      res.send(err);

   Settings.find({}).execFind (err, settings) ->
      if (err)
        res.send(err)
      res.json(settings);
      return
    return
  return

exports.users = (req, res) ->
  User.find((err, users) ->
        res.send(err) if (err)

        res.json(users)
      );

exports.userCookie = (req, res) ->
  User.findOne({ 'local.cookie': req.cookies["connect.sid"] }, (err, user) ->
        res.send(err) if (err)
        #console.log user
        res.json(user)
      );

exports.logout = (req, res) ->
  User.update {
      'local.cookie': req.cookies["connect.sid"]
      }, {
      'local.cookie'   : false,
    }, { multi: false }, (err, user) ->
      if (err)
        res.send(err);
      res.json(user)
      return
  return
