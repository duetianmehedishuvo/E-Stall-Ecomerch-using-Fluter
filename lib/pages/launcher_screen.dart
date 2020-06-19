import 'package:estallecomerch/helpers/authentication_service.dart';
import 'package:estallecomerch/helpers/user_utils.dart';
import 'package:estallecomerch/pages/homeScreen.dart';
import 'package:estallecomerch/pages/login_page.dart';
import 'package:flutter/material.dart';

class LauncherScreen extends StatefulWidget {

  static final route='/launch';

  @override
  _LauncherScreenState createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {

  UserUtils userUtils;
  AuthenticationService _service;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userUtils=UserUtils();
    _service=AuthenticationService();
    _service.user.then((user){
      if(user!=null){
        Navigator.of(context).pushReplacementNamed(HomeScreen.route);
      }else{
        Navigator.of(context).pushReplacementNamed(LoginPage.route);
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
