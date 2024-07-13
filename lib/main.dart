import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/Client/sign_up.dart';
import 'package:store/view/home.dart';

const Color pink = Color.fromARGB(255, 12, 143, 250);
const Color pinkDark = Color.fromARGB(255, 4, 83, 107);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedLocale = prefs.getString('locale');

  runApp(MyApp(savedLocale));
}

class MyApp extends StatelessWidget {
  final String? savedLocale;

  const MyApp(this.savedLocale, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<AlignmentGeometry> _alignAnimation;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _alignAnimation = Tween<AlignmentGeometry>(
      begin: Alignment.bottomCenter,
      end: Alignment.bottomCenter,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );

    _checkAuthStatus();
  }

  void _checkAuthStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');
    await Future.delayed(Duration(seconds: 5));

    if (isLoggedIn != null && isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Home(
            username: prefs.getString('username') ?? 'user',
            email: prefs.getString('email') ?? 'email@example.com',
          ),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Sign_Up()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 192, 192, 190),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Center(
              child: Image.asset(
                "images/store.png",
                width: 300,
              ),
            ),
          ),
          Text("V 0.0.1"),
          Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: Center(
              child: BlurContainer(
                containerHeight: 210,
                child: AlignTransition(
                  alignment: _alignAnimation,
                  child: RotationTransition(
                    turns: _rotationAnimation,
                    child: const Rectangle(
                      color1: pink,
                      color2: pinkDark,
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BlurContainer extends StatelessWidget {
  final double containerHeight;
  final Widget child;

  const BlurContainer({
    Key? key,
    required this.containerHeight,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            color: Color.fromARGB(255, 192, 192, 190).withOpacity(0.1),
            child: child,
          ),
        ),
      ),
    );
  }
}

class Rectangle extends StatelessWidget {
  final Color color1;
  final Color color2;
  final double width;
  final double height;

  const Rectangle({
    Key? key,
    required this.color1,
    required this.color2,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
        ),
      ),
    );
  }
}
