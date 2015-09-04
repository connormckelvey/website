var express = require('express')l
var app = express();

app.use(express.static(__dirname + '/_site'));
app.listen(process.env.PORT || 5000);