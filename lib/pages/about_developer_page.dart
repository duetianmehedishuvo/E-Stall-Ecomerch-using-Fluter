import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_about/material_about.dart';

class AboutDeveloperPage extends StatefulWidget {
  @override
  _AboutDeveloperPageState createState() => _AboutDeveloperPageState();
}

class _AboutDeveloperPageState extends State<AboutDeveloperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaterialAbout(
        banner: Image.asset(
          'images/duet.jpg',
          height: 120.0,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        dp: Image.asset(
          "images/shuvo.jpg",
          height: 190.0,
          fit: BoxFit.fill,
        ),
        name: "Mehedi Hasan Shuvo",
        position: "Android & IOS Developer",
        description: "I'm warmed of mobile technologies. \n Ideas Maker, curious and nature lover",
        seperatorColor: Colors.grey,
        iconColor: Colors.black,
        textColor: Colors.black,
        playstoreID: "Bd+Mehedi+Shuvo",
        github: "duetinmehedishuvo",
        facebook: "m.mehedihasanshuvo.in", //e.g jideguru
        youtube: "channel/UCSvBjGRXbx_yWKuAExIA8VQ?view_as=subscriber",
        linkedin: "mehedi-hasan-shuvo-94651a165/",
        email: "duetinmehedishuvo@gmail.com",
        whatsapp: "+8801303129515", //without international code e.g 22994684468.

      ),
    );
  }
}
