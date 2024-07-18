import 'package:flutter/material.dart';
import 'package:store/model/product.dart';
import 'package:store/view/home.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  var name = TextEditingController();
  var description = TextEditingController();
  var quantite = TextEditingController();
  var price = TextEditingController();
  List<String> selectedSizes = [];
  List<File> _images = []; 

  List<Product> dataList = [];
  bool isSwitched = false;

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    setState(() {
      if (pickedFiles != null) {
        _images = pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
      } else {
        print('No images selected.');
      }
    });
  }

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
            Center(
              child: Text(
                "Add your product",
                style: TextStyle(
                  fontFamily: 'Baskervville',
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
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
            ElevatedButton(
              onPressed: _pickImages,
              child: Text("Pick Images from Gallery"),
            ),
            SizedBox(height: 20),
            _images.isEmpty
                ? Text('No images selected.')
                : Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _images.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.file(
                            _images[index],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
            SizedBox(height: 20),
            Container(
              child: Row(
                children: [
                  _buildSizeCard("XL"),
                  _buildSizeCard("L"),
                  _buildSizeCard("XXL"),
                  _buildSizeCard("XXXL"),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  dataList.add(
                    Product(
                      name: name.text,
                      description: description.text,
                      quantite: quantite.text,
                      price: price.text,
                      isSwitched: isSwitched,
                      sizes: selectedSizes,
                      imagePaths: _images.map((image) => image.path).toList(), 
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

  Widget _buildSizeCard(String size) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (selectedSizes.contains(size)) {
              selectedSizes.remove(size);
            } else {
              selectedSizes.add(size);
            }
          });
        },
        child: Card(
          color: selectedSizes.contains(size) ? Colors.blue : Colors.white,
          child: Center(
            child: Text(
              size,
              style: TextStyle(
                fontFamily: 'Baskervville',
                fontSize: 24,
                color: selectedSizes.contains(size) ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
