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
busboy = require('connect-busboy')
compressor = require('node-minify')

app = module.exports = express()

mongoose.connect('mongodb://dakolech:dako222@novus.modulusmongo.net:27017/po5Vymyq');



# all environments
app.set('port', process.env.PORT || 3000);
app.set('views', __dirname + '/views');
app.set('view engine', 'jade');
app.use(morgan('dev'));
app.use(busboy());
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
app.get('/partials/admin/:name', routes.partialsAdmin);
app.get('/partials/templates/:name', routes.templates);

# JSON API
app.get('/api/name', api.name);

app.get('/api/products', api.products);
app.get('/api/product/:id', api.product);
app.delete('/api/product/:id', api.deleteProduct);
app.post('/api/product', api.addProduct);
app.post('/api/product/:id', api.editProduct);
app.post('/api/product/review/:id', api.addReviewToProduct);

app.get('/api/products/:category', api.productsCategory)

app.get('/api/categories', api.categories);
app.post('/api/category', api.addCategory);
app.get('/api/category/:id', api.category);
app.post('/api/category/:id/:oldname', api.editCategory);
app.delete('/api/category/:id/:name', api.deleteCategory);

app.get('/api/product/image/:file', api.image);
app.post('/api/productImage/:id', api.AddImage);
app.delete('/api/productImage/:id/:name', api.deleteImage);

app.get('/api/sites', api.sites);
app.get('/api/site/:title', api.site);
app.post('/api/site', api.addSite);
app.post('/api/site/:id', api.editSite);
app.delete('/api/site/:id', api.deleteSite);
app.post('/api/sites/order', api.orderSite);

app.get('/api/settings', api.settings);
app.post('/api/settings', api.editSettings);
app.post('/api/asettings', api.addSettings);






# redirect all others to the index (HTML5 history)
app.get('*', routes.index);


###
new compressor.minify({
    type: 'gcc',
    fileIn: ['public/js/app.js', 'public/js/controllers.js', 'public/js/directives.js', 'public/js/filters.js', 'public/js/services.js'],
    fileOut: 'public/js-min/app.js',
    callback: (err, min) ->
        console.log(err) if err
        #console.log(min);
});

new compressor.minify({
    type: 'yui-css',
    fileIn: 'public/css/style.css',
    fileOut: 'public/css-min/style.js',
    callback: (err, min) ->
        console.log(err) if err
        #console.log(min);
});
###

http.createServer(app).listen(app.get('port'), -> 
  console.log('Express server listening on port ' + app.get('port'));
)
