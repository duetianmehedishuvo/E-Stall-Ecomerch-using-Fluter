import 'dart:async';
import 'package:estallecomerch/pages/launcher_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LauncherScreen())));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset('images/splash.png',width: double.infinity,height: double.infinity,fit: BoxFit.cover,),
            Image.asset('images/splash_image.png'),
            AnimatedContainer(
              duration: Duration(seconds: 3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width:130,
                      height: 130,
                      alignment: Alignment.center,
                      decoration:BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(200)
                      ),
                      child: Text('E-stall',style: TextStyle(color: Colors.white,
                      fontSize: 22,
                      letterSpacing: .8,
                      fontWeight: FontWeight.bold),)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}