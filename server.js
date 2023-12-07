const express=require('express');
const hbs=require('hbs');
const path=require('path');
const session = require('express-session')
// const fileUpload = require('express-fileupload');

const port=process.env.PORT || 3000
const app=express();

app.set('view engine','hbs');
app.set('views',path.join(__dirname,'./views'));
hbs.registerPartials(path.join(__dirname, `./views`));
hbs.registerPartials(path.join(__dirname, `./views/partials`));
require('./extras/helpers')

app.use(express.json());
app.use(express.static(path.join(__dirname,'./assets')));
app.use(session({ secret: 'keyboard cat', cookie: { maxAge: 40*60000 }}))


app.use(require('./routes/rt_index'))


app.listen(port,()=>{
    console.log(`Link del servidor http://localhost:${port}`)
})  
