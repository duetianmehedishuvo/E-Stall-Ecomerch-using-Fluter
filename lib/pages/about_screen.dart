import 'package:estallecomerch/helpers/user_service.dart';
import 'package:estallecomerch/models/refund_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {

  bool isAboutUs=false;
  bool isprivacyPolicy=false;
  bool isRefundPolicy=false;

  String refundtext='';
  String aboutUstext='';
  String privacy_policy='';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(int.parse('#F1F1F1'.replaceAll('#', '0xff'))),
      appBar: AppBar(
        title: Text('About'),
      ),
      body:ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            color: Colors.white,
            alignment: Alignment.center,
            child: Image.asset('images/Behind app logo.png',width: 150,height: 150,fit: BoxFit.fill,),
          ),

          Container(
            color: Colors.white,
            margin: EdgeInsets.only(left: 10,right: 10,bottom: 1),
            padding: EdgeInsets.only(left: 8,right: 8),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('About us',style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),),
                    IconButton(
                      icon: Icon(Icons.arrow_downward),
                      onPressed: (){
                        setState(() {
                          isAboutUs=!isAboutUs;

                          UserService.getRefundModels().then((value) {
                            setState(() {
                              aboutUstext=value.aboutUs;

                            });
                          });

                        });
                      },
                    ),
                  ],
                ),
                isAboutUs?Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text('${aboutUstext}'),
                ):Container()
              ],
            ),
          ),

          Container(
            color: Colors.white,
            margin: EdgeInsets.only(left: 10,right: 10,bottom: 1),
            padding: EdgeInsets.only(left: 8,right: 8),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Delivery & Refund Policy',style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),),
                    IconButton(
                      icon: Icon(Icons.arrow_downward),
                      onPressed: (){
                        setState(() {
                          isprivacyPolicy=!isprivacyPolicy;

                          UserService.getRefundModels().then((value) {
                            setState(() {
                              privacy_policy=value.privacyPolicy;

                            });
                          });

                        });
                      },
                    ),
                  ],
                ),
                isprivacyPolicy?Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text('${privacy_policy}'),
                ):Container()
              ],
            ),
          ),

          Container(
            color: Colors.white,
            margin: EdgeInsets.only(left: 10,right: 10,bottom: 1),
            padding: EdgeInsets.only(left: 8,right: 8),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Refund Policy',style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),),
                    IconButton(
                      icon: Icon(Icons.arrow_downward),
                      onPressed: (){
                        setState(() {
                          isRefundPolicy=!isRefundPolicy;

                          UserService.getRefundModels().then((value) {
                            setState(() {
                              refundtext=value.refundPolicy;

                            });
                          });
                        });
                      },
                    ),
                  ],
                ),
                isRefundPolicy?Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(refundtext),
                ):Container()
              ],
            ),
          ),
        ],
      ),
    );
  }

}
