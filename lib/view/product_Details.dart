import 'package:flutter/material.dart';

void main() {
  runApp(Details());
}
class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Details"),),
        body: ListView(
        ),
        
      ),
    );
  }
}