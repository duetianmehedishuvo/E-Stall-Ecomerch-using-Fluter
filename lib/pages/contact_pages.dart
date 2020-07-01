import 'package:estallecomerch/pages/about_developer_page.dart';
import 'package:estallecomerch/pages/contact_us_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  String phoneNumber = "09638617507";
  String email = "estall607@gmail.com";

  Future<void> _callNumber() async{
    final phoneUrl = 'tel:$phoneNumber';
    if(await canLaunch(phoneUrl)){
      await launch(phoneUrl);
    }else{
      throw 'Cannot launch phone call';
    }
  }

  Future<void> _mailto() async{
    final phoneUrl = 'mailto:$email';
    if(await canLaunch(phoneUrl)){
      await launch(phoneUrl);
    }else{
      throw 'Cannot launch phone call';
    }
  }

  Future<void> _sendUrl(String url)async{

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back,color: Colors.blue,),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                  Text("Contact us", style: TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.w500 ),),
                ],
              ),
            ),
            Image.asset("images/logo.png",height: 150, width: 150,),
            Container(
              margin: EdgeInsets.only(left: 12,right: 12),
              child: Card(
                elevation: 1.6,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 5),
                          child: InkWell(
                            onTap: _callNumber,
                            child: Column(
                              children: <Widget>[
                                Image.asset("images/phoneIcon.png", height: 50, width: 50, fit: BoxFit.cover,),
                                SizedBox(height: 5,),
                                FittedBox(child: Text("Call"))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child:InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=>ContactUsFormScreen()
                            ));
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Column(
                              children: <Widget>[
                                Image.asset("images/sms.png",  height: 50, width: 50, fit: BoxFit.cover,),
                                SizedBox(height: 5,),
                                FittedBox(child: Text("Support"))
                              ],
                            ),
                          ),
                        ),),

                      Expanded(
                        child: InkWell(
                          child: Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Column(
                              children: <Widget>[
                                Image.asset("images/location.png", height: 50, width: 50, fit: BoxFit.cover,),
                                SizedBox(height: 5,),
                                FittedBox(child: Text("Maps"))
                              ],
                            ),
                          ),
                          onTap: (){
                            _sendUrl("https://www.google.com/maps/place/23%C2%B004'20.2%22N+90%C2%B014'11.5%22E/@23.0722672,90.2359828,171m/data=!3m2!1e3!4b1!4m13!1m6!3m5!1s0x37556be7eeed0b87:0x6342d05b92bb7877!2sKalkini+Press+Club!8m2!3d23.0734937!4d90.2330491!3m5!1s0x0:0x0!7e2!8m2!3d23.0722662!4d90.2365303");
                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Column(
                              children: <Widget>[
                                Image.asset("images/fb.png", height: 50, width: 50, fit: BoxFit.cover,),
                                SizedBox(height: 5,),
                                FittedBox(child: Text("facebook"))
                              ],
                            ),
                          ),
                          onTap: (){
                            _sendUrl('https://facebook.com/estall.com.bd');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.location_on, color: Colors.black45,),
                  SizedBox(width: 8,),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("Address", style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w500),),
                          SizedBox(height: 10,),
                          Text("Jhautola "
                              " Kalkini,Madaripur",maxLines: 2,
                            style: TextStyle (fontSize: 17, fontWeight: FontWeight.w400,),
                            overflow: TextOverflow.ellipsis,)
                        ],
                      ),
                      onTap: (){
                        _sendUrl("https://www.google.com/maps/place/23%C2%B004'20.2%22N+90%C2%B014'11.5%22E/@23.0722672,90.2359828,171m/data=!3m2!1e3!4b1!4m13!1m6!3m5!1s0x37556be7eeed0b87:0x6342d05b92bb7877!2sKalkini+Press+Club!8m2!3d23.0734937!4d90.2330491!3m5!1s0x0:0x0!7e2!8m2!3d23.0722662!4d90.2365303");
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.email, color: Colors.black45,),
                  SizedBox(width: 8,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("Email", style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w500),),
                        SizedBox(height: 10,),
                        InkWell(
                          onTap: _mailto,
                          child: Text(email,
                            style: TextStyle (decoration: TextDecoration.underline,fontSize: 17, fontWeight: FontWeight.w400,),),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.phone, color: Colors.black45,),
                  SizedBox(width: 8,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("Customer Care", style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w500),),
                        SizedBox(height: 10,),
                        InkWell(
                          onTap: _callNumber,
                          child: Text(phoneNumber,
                            style: TextStyle (decoration: TextDecoration.underline,fontSize: 17, fontWeight: FontWeight.w400,),),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),


          ],
        ),
      ),




    );
  }
}