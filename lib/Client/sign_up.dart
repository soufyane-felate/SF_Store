import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/view/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CheckAuth(),
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  void _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstTime = prefs.getBool('isFirstTime');
    if (isFirstTime != null && !isFirstTime) {
      setState(() {
        _isFirstTime = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isFirstTime ? Sign_Up() : Home(email: 'email@gmail.com', username: 'user');
  }
}

class Sign_Up extends StatefulWidget {
  const Sign_Up({super.key});

  @override
  State<Sign_Up> createState() => _Sign_UpState();
}

class _Sign_UpState extends State<Sign_Up> {
  var userController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(fontFamily: 'Baskervville', fontSize: 40),
              ),
              SizedBox(height: 15.0),
              TextField(
                controller: userController,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 15.0),
              TextField(
                controller: passController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 15.0),
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('isFirstTime', false);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(
                        username: userController.text,
                        email: emailController.text,
                      ),
                    ),
                  );
                },
                child: Text("Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}