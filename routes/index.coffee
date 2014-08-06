
exports.index = (req, res) ->
  res.render('index');
  
#exports.products = (req, res) ->
 # res.render('products');

exports.admin = (req, res) ->
  res.render('admin');


exports.partials = (req, res) ->
  name = req.params.name;
  res.render('partials/' + name);

exports.partialsAdmin = (req, res) ->
  name = req.params.name;
  res.render('partials/admin/' + name);

exports.templates = (req, res) ->
  name = req.params.name;
  res.render('partials/templates/' + name);
