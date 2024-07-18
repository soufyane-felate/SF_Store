import 'package:flutter/material.dart';
import 'package:store/model/product.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Color.fromARGB(171, 7, 231, 231),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(product.img, fit: BoxFit.cover),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    product.name,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Price: ${product.price} DH",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Quantity: ${product.quantite} ",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 8),
               Row(
              children: [
                Text(
                  product.isSwitched ? "Free Livraison" : "Livraison Not Free",
                  style: TextStyle(
                    fontSize: 18,
                    color: product.isSwitched ? Colors.green : Colors.red,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  product.isSwitched ? Icons.check_circle : Icons.cancel,
                  color: product.isSwitched ? Colors.green : Colors.red,
                ),
              ],
            ),
            
                SizedBox(height: 8),
                Text(
                  product.description,  
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
            
                 ElevatedButton(
                        onPressed: () {
                        //  Navigator.push(context,
                         //     MaterialPageRoute(builder: (context) => ()));
                        },
                        child: Text(
                          'Add to cart',
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 6, 245, 245),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
