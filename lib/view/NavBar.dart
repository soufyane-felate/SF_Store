// navbar.dart
import 'package:flutter/material.dart';
import 'package:store/admin/login.dart';
import 'package:store/view/home.dart';
import 'package:store/view/settings.dart';

class NavBar extends StatelessWidget {
  final String username;
  final String email;

  const NavBar({Key? key, required this.email, required this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(username),
          accountEmail: Text(email),
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
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text("Home"),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Home(email: email, username: username,dataList: [],)));
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Settings"),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Settings()));
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("admin"),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          },
        ),
      ],
    ));
  }
}
