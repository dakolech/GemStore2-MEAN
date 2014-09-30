
exports.index = (req, res) ->
  #req.cookies.remember
  console.log("connect.sid: ", req.cookies["connect.sid"])
  #console.log req.cookies.remember
  #console.log(req.cookies)
  #console.log(req.session)
  res.render('index')
  
#exports.products = (req, res) ->
 # res.render('products');

exports.admin = (req, res) ->
  if (req.isAuthenticated())
    res.render('admin')
  else 
  	res.redirect('/');
  


exports.partials = (req, res) ->
  name = req.params.name
  res.render('partials/' + name)

exports.partialsAdmin = (req, res) ->
  name = req.params.name
  res.render('partials/admin/' + name)

exports.templates = (req, res) ->
  name = req.params.name
  res.render('partials/templates/' + name)
