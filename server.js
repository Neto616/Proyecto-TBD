const express=require('express');
const hbs=require('hbs');
const path=require('path');


// const fileUpload = require('express-fileupload');

const port=process.env.PORT || 3000
const app=express();

app.set('view engine','hbs');
app.set('views',path.join(__dirname,'./views'));
hbs.registerPartials(path.join(__dirname, `./views`));
hbs.registerPartials(path.join(__dirname, `./views/partials`));

app.use(express.json());
app.use(express.static(path.join(__dirname,'./assets')));

app.use(require('./routes/rt_index'))


app.listen(port,()=>{
    console.log(`Link del servidor http://localhost:${port}`)
})  
