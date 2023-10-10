const jwt = require("jsonwebtoken") ;

const auth = async (req , res , next) => {
     try{
        //here we will authenticate if the user is authorized ie if he is the admin using token 
        const token  = req.header("x-auth-token"); 
        if(!token) return res.status(401).json({msg: "No auth token , access denied !"}); 
        
        const isVerified = jwt.verify(token , "passwordKey");
        if(!isVerified) return res.status(401),json({msg : "Authorization failed , access denied. "});
        
         req.user = isVerified.id ; // if the user is authenticated , we access it using req.user 
         req.token = token ; // similary token is verified and it is stored in req.token 
         next() ; // now after authentication , we call the callback function 
        
     }  catch(err){
        res.status(300).json({error : err.message});
     }
}

module.exports = auth; 