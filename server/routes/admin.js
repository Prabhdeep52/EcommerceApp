const express = require("express") ; 
const adminRouter = express.Router() ; 
const admin = require("../middleware/admin") ; 
const Product = require("../models/product");

// adding product 

adminRouter.post("/admin/add-product"  ,async(req , res ) =>{
      /// add admin middleware here so that we check for token first . just write admin before async
    try{
        const {name , description , price , quantity ,category,images} = req.body ; 
        let product = new Product({
            name , 
            description , 
            images , 
            quantity , 
            price , 
            category 
        });

        product = await product.save() ; 
        res.json(product) ; 

    }catch(err){
        res.status(500).json({error : err.message});
    }
}  );

//getting the products 

adminRouter.get("/admin/get-products"  , async(req , res) => {
      /// add admin middleware here so that we check for token first . just write admin before async
    try{
        const products = await Product.find({}); //this will all the products 
        res.json(products) ; 

    }catch(err){
        res.status(500).json({error : err.message});
    }
})


// deleting a product 

adminRouter.post("/admin/delete-product" , async(req , res) => {
    try{
        const {id} = req.body ; 
        let product = await Product.findByIdAndDelete(id);
       
        res.json(product);
    }catch(err){
        res.json(500).json({error: err.message}); 
    }
})




module.exports = adminRouter;