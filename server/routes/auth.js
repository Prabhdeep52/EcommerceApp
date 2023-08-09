const express = require("express") ; 
const bcryptjs = require("bcryptjs") ; 
const User = require("../models/user") ;
const user = require("../models/user");
const jwt = require("jsonwebtoken") ;
const auth = require("../middleware/auth");

const authRouter = express.Router() ; 

//SIGNUP ROUTE 

authRouter.post("/api/signup" ,  async function(req , res){
    //step 1 : get data from client 
    //step 2 : save data in database
    //step 3 : send data back to user
    
    try{
        const { name , email , password } = req.body ; 
    
        const existingUser = await User.findOne({email : email }); //it find the user with the same email int he database and returns if the user with same email exists or not 
        
        if(existingUser){
            return res.status(400).json({msg : "User with same email already exists ! "}); 
        }

        const hashedPassword = await bcryptjs.hash(password , 8); //it hashes the pasword by adding salt of 8 (read about salt on docs )
    
        let NewUser = new User({
            email , password : hashedPassword, name , 
        })
    
        NewUser = await NewUser.save(); 
        res.json(NewUser) ; 
    }
    catch(e){
        res.status(500).json({error : e.message}); 
    }

});

//LOGIN OR SIGN IN ROUTE 

authRouter.post("/api/signin" , async function(req , res){
    try{
        
        const {email , password} = req.body ; 

        // finding the user with same email as the entered email 

        const findUser = await User.findOne({email}) ; 
        //if user with that email doesnt exists 
        if(findUser == null){
        return res.status(400).json({msg : "User with this email doesn't exists.Create one ."})
        }

        // if email is present , then we check if the entered password matches with the original password in database
        // password is encrypted in database , so we use bcrypt again to check it

       const isPassMatch = await bcryptjs.compare(password , findUser.password); 

       if(!isPassMatch){
        return res.status(400).json({msg : "Incorrect password !"}); 
       }

       const token = jwt.sign({id : findUser._id} , "passwordKey" );
       res.json({token , ...findUser._doc}); 
       /* ... is used so that the property "token" is added along with the user data in the json data object . 
       for eg : 
       {
        'token' : "sometoken" , 
        'name' : "myname", 
        'email' : "emailaddress"
       }
       */

    }catch(e){
        res.status(500).json({error : e.message}); 
    }
});


// getting user token  


authRouter.post("/tokenIsValid" , async function(req , res){
    try{
        const token = req.header('x-auth-token'); 
        if(!token)  return res.json(false); 
        
        const isVerified = jwt.verify(token , "passwordKey");
        
        if(!isVerified) return res.json(false); 

        const user = await User.findById(isVerified.id) ;
        if(!user) return res.json(false) ; 
        
        res.json(true) ; 

    }catch(e){
        res.status(500).json({error : e.message}); 
    }
});

// GETTING USER DATA

authRouter.get("/" , auth , async function(req , res){
    const user = await User.findById(req.id) ; 
    res.json({...user._doc , token : req.token})
} )


module.exports = authRouter ; 
