import 'package:estallecomerch/helpers/authentication_service.dart';
import 'package:estallecomerch/models/profile.dart';
import 'package:estallecomerch/pages/login_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String userEmailKey;
  var pas;


  Profile profile=Profile();
  AuthenticationService authenticationService;
  final _formKey=GlobalKey<FormState>();
  String uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authenticationService=AuthenticationService();
    AuthenticationService.getUserPhoneNumberByPreference().then((phoneNumberKey){
      setState(() {
        userEmailKey=phoneNumberKey;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    authenticationService=null;
  }

  _submit() async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();

      try{

        authenticationService.updateProfile(profile).then((_){
          setState(() {
            if(profile.password!=pas){
              authenticationService.changePassword(profile.password);
              Navigator.of(context).pushReplacementNamed(LoginPage.route);
            }
          });
        });



      }catch(error){
        print(error.message);
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Your Profile'),
        ),
        body: Center(
          child: FutureBuilder(
            future: authenticationService.getUserProfileByEmail(userEmailKey),
            builder: (context,AsyncSnapshot<Profile> snapshot){
              if(snapshot.hasData){

                pas=snapshot.data.password;

                return ListView(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Image.asset(
                        "images/user.png",
                        width: 70,
                        height: 70,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'নাম ',
                                    border: OutlineInputBorder()
                                ),
                                initialValue: snapshot.data.name,
                                validator: (value){
                                  if(value.isEmpty){
                                    return 'Give a Name';
                                  }
                                  return null;
                                },
                                onSaved: (value){
                                  profile.name=value;
                                },
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              color: Colors.white,
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    labelText: 'মোবাইল নাম্বার',
                                    border: OutlineInputBorder()
                                ),
                                initialValue: snapshot.data.phoneNumber,
                                validator: (value){
                                  if(value.isEmpty){
                                    return 'Phone Number Must Be Includded';
                                  }
                                  if(value.length<11){
                                    return 'give Phone number at least 11 character';
                                  }
                                  return null;
                                },
                                onSaved: (value){
                                  profile.email='$value@gmail.com';
                                  profile.phoneNumber=value;
                                },
                              ),
                            ),
                            SizedBox(height: 10,),

                            Container(
                              color: Colors.white,
                              child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: 'পাসওয়ার্ড  ',
                                    border: OutlineInputBorder()
                                ),
                                initialValue: snapshot.data.password,
                                validator: (value){
                                  if(value.isEmpty){
                                    return 'password field is Empty';
                                  }
                                  if(value.length<6){
                                    return 'Enter Your valid Password al least 6 character';
                                  }
                                  return null;
                                },
                                onSaved: (value){
                                  profile.password=value;
                                },
                              ),
                            ),
                            SizedBox(height: 10,),

                            Container(
                              color: Colors.white,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    labelText: ' ঠিকানা  *',
                                    border: OutlineInputBorder()
                                ),
                                // ignore: missing_return
                                validator: (value){
                                  if(value.isEmpty){
                                    return 'This field must be required';
                                  }
                                },
                                initialValue: snapshot.data.address,
                                onSaved: (value){
                                  profile.address=value;
                                },
                                maxLines: null,
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              width: MediaQuery.of(context).size.width/2,
                              child: RaisedButton(
                                child: Text('Update',style: TextStyle(fontSize: 16,color: Colors.white.withOpacity(.8)),),
                                color: Colors.blue.withOpacity(.5),
                                onPressed: _submit,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              if(snapshot.hasError){

              }
              return CircularProgressIndicator();

            },
          ),
        ),
      ),
    );
  }
}
