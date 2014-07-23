
/**
 * Module dependencies
 */

var express = require('express'),
  bodyParser = require('body-parser'),
  methodOverride = require('method-override'),
  errorHandler = require('error-handler'),
  morgan = require('morgan'),
  routes = require('./routes'),
  api = require('./routes/api'),
  http = require('http'),
  path = require('path'),
  mongoose = require('mongoose'); 	

var app = module.exports = express();

mongoose.connect('mongodb://dakolech:dako222@novus.modulusmongo.net:27017/po5Vymyq');

/**
 * Configuration
 */

// all environments
app.set('port', process.env.PORT || 3000);
app.set('views', __dirname + '/views');
app.set('view engine', 'jade');
app.use(morgan('dev'));
//app.use(bodyParser());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended: true
}));
app.use(methodOverride());
app.use(express.static(path.join(__dirname, 'public')));

var env = process.env.NODE_ENV || 'development';

// development only
//if (app.get('env') === 'development') {
//  app.use(errorHandler());
//}

// production only
if (env === 'production') {
  // TODO
}

if (app.get('env') === 'development') {
  app.locals.pretty = true;
}


/**
 * Routes
 */

// serve index and view partials
app.get('/', routes.index);
app.get('/partials/:name', routes.partials);

// JSON API
app.get('/api/name', api.name);

app.get('/api/products', api.products);
app.get('/api/product/:id', api.product);
//app.post('/api/post', api.addPost);
//app.put('/api/post/:id', api.editPost);
//app.delete('/api/post/:id', api.deletePost);


// redirect all others to the index (HTML5 history)
app.get('*', routes.index);


/**
 * Start Server
 */

http.createServer(app).listen(app.get('port'), function () {
  console.log('Express server listening on port ' + app.get('port'));
});
