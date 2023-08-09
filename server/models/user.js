const mongoose = require("mongoose") ; 


//it defines the structure of the data/user on the app , or the data which will be saved 

const userSchema = mongoose.Schema({
    name: {
        required : true , 
        type : String , 
        trim : true , 
    }, 
    email : {
        required :true , 
        type : String , 
        trim : true , 
        validate : {
            validator : (value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re) ; //it return true or false if it validate or not 
            }, 
            //message will be triggered if validator returns false 
            message : "Please enter a valid E-mail address "
        }, 
    }, 
    password : {
        required : true , 
        type : String , 
    }, 
    address : {
        type : String , 
        default : " "
    }, 
    //this is the type of the user , it defaults to the the user being the normal user , we can also create a seller type and buyer type 
    type : {
        type : String , 
        default : "user" , 
    }
    //CART
});

const user = mongoose.model("user" , userSchema) ;
module.exports  = user ; 