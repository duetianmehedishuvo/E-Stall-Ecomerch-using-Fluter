import 'package:estallecomerch/helpers/user_service.dart';
import 'package:estallecomerch/models/contact_us_models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class ContactUsFormScreen extends StatefulWidget {
  @override
  _ContactUsFormScreenState createState() => _ContactUsFormScreenState();
}

class _ContactUsFormScreenState extends State<ContactUsFormScreen> {

  ContactUsModels contactUsModels;
  final formState=GlobalKey<FormState>();
  String formattedDate,formatedtime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contactUsModels=ContactUsModels();

    DateTime now = DateTime.now();
    formattedDate = DateFormat('EEE d MMM').format(now);
    formatedtime = DateFormat('hh:mm:ss a').format(now);

    UserService.getAllContactUsModelsinfo('Sat 27 Jun').then((contactUs){
      setState(() {
        contactUs.forEach((element) {
          print(element.keyName);
        });
      });
    });

  }

  _saveContactUsModels(){
    if(formState.currentState.validate()){
      formState.currentState.save();

      contactUsModels.keyName='${contactUsModels.phoneNumber} ${formatedtime}';
      UserService.addContactUs(contactUsModels, formattedDate).then((_) {
        setState(() {
          Toast.show('Message Sent', context);
          Navigator.of(context).pop();
        });
      });


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(int.parse('#F1F1F1'.replaceAll('#', '0xff'))),
      body: Container(
        padding: EdgeInsets.all(8),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Text('Contact Us',style: TextStyle(
                color: Colors.blue,
                fontSize: 28,
              ),),

              Form(
                key: formState,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 13,),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value){
                        if(value.isEmpty){
                          return 'Name Should Not be Empty';
                        }
                        return null;
                      },
                      onSaved: (value){
                        contactUsModels.name=value;
                      },
                    ),
                    SizedBox(height: 13,),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value){
                        contactUsModels.email=value;
                      },
                    ),
                    SizedBox(height: 13,),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value){
                        if(value.length<11){
                          return 'phone number at least 11 characher';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      maxLength: 14,
                      onSaved: (value){
                        contactUsModels.phoneNumber=value;
                      },
                    ),
                    SizedBox(height: 13,),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Message',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: null,
                      maxLength: 250,
                      validator: (value){
                        if(value.length<5){
                          return 'Message Should be at least 5 character';
                        }
                        return null;
                      },
                      onSaved: (value){
                        contactUsModels.message=value;
                      },
                    ),
                    SizedBox(height: 13,),
                    Container(
                      alignment: Alignment.centerRight,
                      child:FlatButton.icon(onPressed: (){
                        _saveContactUsModels();
                      }, icon: Icon(Icons.send,color: Colors.white,), label: Text('Send Message',style: TextStyle(
                        color: Colors.white,fontSize: 16,
                      ),),
                        color: Color(int.parse('#3479B7'.replaceAll('#', '0xff'))),),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
