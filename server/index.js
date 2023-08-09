//import from packages
const express = require("express");
const mongoose = require("mongoose") ; 

//import from other files 
const authRouter = require("./routes/auth");


const app = express()  ;
const port = 3000 ;
const db = "mongodb+srv://prabhdeep:flutterprojectecommerce@cluster0.whztce9.mongodb.net/?retryWrites=true&w=majority"

//middleware 
app.use(express.json()) ; 
app.use(authRouter)  ;

//connection

mongoose.connect(db).then(() => {
    console.log("connection established") ;
}).catch((e) => {
    console.log(e) ; 
})

app.get("/" , function(req , res){
    res.send("hello world") ;
})


app.listen(port , "0.0.0.0", function(req , res){
    console.log('Server running at port ' + port);
})