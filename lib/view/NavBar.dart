// navbar.dart
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text("Soufyane felate"),
          accountEmail: Text("leader001@gmail.com"),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
              child: Image.network(
                "https://img.freepik.com/premium-photo/arab-man-is-shopping-supermarket_262099-4365.jpg?uid=R136179215&ga=GA1.1.1183347231.1719494592&semt=sph",
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/man.jpg"), fit: BoxFit.cover),
          ),
        )
      ],
    ));
  }
}
