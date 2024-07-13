import 'dart:async';
import 'package:flutter/material.dart';
import 'NavBar.dart';
import 'product_Details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(
        email: 'email@gmail.com',
        username: 'user',
      ),
      debugShowCheckedModeBanner:
          false, // Set this to false to remove the debug banner
    );
  }
}

class Home extends StatefulWidget {
  final String username;
  final String email;
  final String img;
  final String quantite;
  final String description;
  final String name;

  const Home(
      {Key? key,
      required this.email,
      required this.username,
      this.img = "",
      this.quantite = "",
      this.description = "",
      this.name = ""})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();
  final List<String> images = [
    "images/imgTime.jpg",
    "images/timesheet.png",
    "images/imgTime.jpg",
    "images/timesheet.png",
    "images/smart_watch.webp",
    "images/sa3awomen.webp",
    "images/S88ef21e801784232887782184dbd37dbo.jpg_220x220q75.jpg_.webp"
  ];

  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(
        username: widget.username,
        email: widget.email,
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(171, 7, 231, 231),
        title: Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 600,
                child: Stack(
                  children: [
                    Positioned(
                      top: 25,
                      left: 20,
                      child: Material(
                        child: Container(
                          height: 170.0,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                offset: Offset(-10, 10),
                                blurRadius: 20.0,
                                spreadRadius: 4.0,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 30,
                      child: Card(
                        elevation: 10.0,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          height: 200,
                          width: 150,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: images.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(images[index]),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 184,
                      top: 25,
                      child: Container(
                        width: 207,
                        color: Colors.amber,
                        child: Center(
                          child: Text(
                            "shop now",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 184,
                      top: 52,
                      child: Container(
                        width: 207,
                        height: 143,
                        color: Color.fromARGB(255, 236, 235, 235),
                        child: Text(
                          " Summer sales up to 50%",
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Baskervville',
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 250,
                      left: 20,
                      right: 20,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...images.map((image) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Card(
                                  elevation: 10.0,
                                  shadowColor: Colors.grey.withOpacity(0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Container(
                                    height: 200,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(image),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            if (widget.img.isNotEmpty)
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                child: Card(
                                  elevation: 10.0,
                                  shadowColor: Colors.grey.withOpacity(0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(widget.img),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.name,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              widget.quantite,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              widget.description,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
