const express = require("express") ; 
const auth = require('../middleware/auth');
const ProductRouter = express.Router() ; 
const Product = require("../models/product");



ProductRouter.get("/api/products/"  , async(req , res) => {
    /// add auth middleware here so that we check for token first . just write auth before async
  try{
    console.log(req.query.category);
      const products = await Product.find({category :req.query.category}); 
      res.json(products) ; 

  }catch(err){
      res.status(500).json({error : err.message});
  }
})




module.exports = ProductRouter ; 