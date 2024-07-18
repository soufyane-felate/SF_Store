import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:store/Client/sign_up.dart';
import 'package:store/model/product.dart';
import 'package:store/view/settings.dart';
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
        dataList: [],
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  final String username;
  final String email;
  final List<Product> dataList;

  const Home({
    Key? key,
    required this.email,
    required this.username,
    required this.dataList,
  }) : super(key: key);

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
  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
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

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(
        username: widget.username,
        email: widget.email,
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(171, 7, 231, 231),
        toolbarHeight: 35,
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: "Settings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            activeIcon: Icon(Icons.shopping_cart_outlined),
            label: "Card",
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    Widget currentPage;
    switch (_selectedIndex) {
      case 0:
        currentPage = _buildHomePage();
        break;
      case 1:
        currentPage = Settings();
        break;
      case 2:
        currentPage = Sign_Up();
        break;
      default:
        currentPage = _buildHomePage();
    }
    return currentPage;
  }

  Widget _buildHomePage() {
    return CustomScrollView(
        slivers: [
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          delegate: _SliverAppBarDelegate(
            minHeight: 60.0,
            maxHeight: 60.0,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 200,
            child: Stack(
              children: [
                Positioned(
                  top: 25,
                  left: 18,
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
                  left: 29,
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
                        "Shop Now",
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
                      "Summer Sales Up to 50%",
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Baskervville',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 30,
            width: double.infinity,
            color: Colors.amber,
            child: Center(
              child: Text(
                "Products",
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Baskervville',
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 2 / 3,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              var data = widget.dataList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetails(product: data),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    color: Color.fromARGB(255, 241, 247, 247),
                    child: Column(
                      children: [
                         Container(
                          width: double.infinity,
                          height: 110,
                          child: data.imagePaths.isNotEmpty
                              ? Image.file(
                                  File(data.imagePaths[0]), 
                                  fit: BoxFit.cover,
                                )
                              : Container(), 
                        ),
                        Center(
                          child: Text(
                            data.name,
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ),
                        Text("${data.price} DH"),
                        Text(
                          data.isSwitched
                              ? "Free Livraison"
                              : "Livraison Not Free",
                          style: TextStyle(
                            color: data.isSwitched ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            childCount: widget.dataList.length,
          ),
        ),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
