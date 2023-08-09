const jwt = require("jsonwebtoken") ; 
const User = require("../models/user");


const admin = async (req , res , next) => {
    try{
         //here we will authenticate if the user is authorized ie if he is the admin using token 
         const token  = req.header("x-auth-token"); 
         if(!token) return res.status(401).json({msg: "No auth token , access denied !"}); 
         
         const isVerified = jwt.verify(token , "passwordKey");
         if(!isVerified) return res.status(401),json({msg : "Authorization failed , access denied. "});

         const user = await User.findById(isVerified.id) ; 
         if(user.type == "user" || user.type == "seller"){
            return res.status(400).json({msg : "You are not the admin"} ) ; 
         }

         req.user = isVerified.token ; 
         req.token = token ; 
         next() ; 

    }catch(e){
        res.status(300).json({error : e.message});
    }
    
}