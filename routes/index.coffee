
exports.index = (req, res) ->
  res.render('index');
  
exports.products = (req, res) ->
  res.render('products');

exports.admin = (req, res) ->
  res.render('admin');


exports.partials = (req, res) ->
  name = req.params.name;
  res.render('partials/' + name);
