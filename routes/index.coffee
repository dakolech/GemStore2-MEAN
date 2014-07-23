
exports.index = (req, res) ->
  res.render('index');
  
exports.products = (req, res) ->
  res.render('products');


exports.partials = (req, res) ->
  name = req.params.name;
  res.render('partials/' + name);
