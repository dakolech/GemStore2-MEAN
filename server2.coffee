express = require('express')
bodyParser = require('body-parser')
methodOverride = require('method-override')
errorHandler = require('error-handler')
morgan = require('morgan')
routes = require('./routes')
api = require('./routes/api')
http = require('http')
path = require('path')
mongoose = require('mongoose')

app = module.exports = express()

mongoose.connect('mongodb://dakolech:dako222@novus.modulusmongo.net:27017/po5Vymyq');



# all environments
app.set('port', process.env.PORT || 3000);
app.set('views', __dirname + '/views');
app.set('view engine', 'jade');
app.use(morgan('dev'));
#app.use(bodyParser());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended: true
}));
app.use(methodOverride());
app.use(express.static(path.join(__dirname, 'public')));

env = process.env.NODE_ENV || 'development';

# development only
#if (app.get('env') === 'development') {
#  app.use(errorHandler());
#}

# production only
#if (env === 'production') {
  # TODO
#}

app.locals.pretty = true if (app.get('env') == 'development') 
  



#Routes


#serve index and view partials
app.get('/', routes.index);
#app.get('/products', routes.products);
app.get('/admin', routes.admin);
app.get('/partials/:name', routes.partials);

# JSON API
app.get('/api/name', api.name);

app.get('/api/products', api.products);
app.get('/api/product/:id', api.product);
app.delete('/api/product/:id', api.deleteProduct);
#app.post '/api/products', (req, res) ->
app.post('/api/product', api.addProduct);
#app.put('/api/post/:id', api.editPost);



# redirect all others to the index (HTML5 history)
app.get('*', routes.index);



http.createServer(app).listen(app.get('port'), -> 
  console.log('Express server listening on port ' + app.get('port'));
)
