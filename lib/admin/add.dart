import 'package:flutter/material.dart';
import 'package:store/model/product.dart';
import 'package:store/view/home.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  var name = TextEditingController();
  var description = TextEditingController();
  var quantite = TextEditingController();
  var img = TextEditingController();
  var price = TextEditingController();

  List<Product> dataList = [];
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 80),
            Text(
              "Add your product",
              style: TextStyle(
                fontFamily: 'Baskervville',
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            SizedBox(height: 100),
            TextField(
              controller: name,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: quantite,
              decoration: InputDecoration(
                labelText: "Quantite",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              controller: description,
              decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text("Free Livraison"),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: price,
              decoration: InputDecoration(
                labelText: "Price",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              controller: img,
              decoration: InputDecoration(
                labelText: "Image URL",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  dataList.add(
                    Product(
                      img: img.text,
                      quantite: quantite.text,
                      description: description.text,
                      name: name.text,
                      price: price.text,
                      isSwitched: isSwitched,
                    ),
                  );
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Product added successfully!"),
                    duration: Duration(seconds: 2),
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(
                      email: "Admin",
                      username: "Admin@gmail.com",
                      dataList: dataList,
                    ),
                  ),
                );
              },
              child: Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}
