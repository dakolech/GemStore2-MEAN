// Generated by CoffeeScript 1.7.1
exports.index = function(req, res) {
  return res.render('index');
};

exports.products = function(req, res) {
  return res.render('products');
};

exports.admin = function(req, res) {
  return res.render('admin');
};

exports.partials = function(req, res) {
  var name;
  name = req.params.name;
  return res.render('partials/' + name);
};
