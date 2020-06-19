import 'package:estallecomerch/helpers/authentication_service.dart';
import 'package:estallecomerch/models/profile.dart';
import 'package:estallecomerch/pages/login_page.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static final route='/signUp';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  Profile profile=Profile();
  AuthenticationService authenticationService;
  final _formKey=GlobalKey<FormState>();
  String uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authenticationService=AuthenticationService();
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
        uid=await authenticationService.signUp(profile.email, profile.password);
        if(uid!=null){
          AuthenticationService.addUserProfile(profile);
          Navigator.of(context).pushReplacementNamed(LoginPage.route);
        }
      }catch(error){
        print(error.message);
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
//          color: Colors.blueGrey.withOpacity(.1),
          child: ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.keyboard_backspace,color: Colors.black,),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  Flexible(
                      flex: 2,
                      child: Text('SingUp Your Info',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,))
                ],
              ),
              AnimatedContainer(
                margin: EdgeInsets.only(top: 50,bottom: 20),
                duration: Duration(milliseconds: 5000),
                child: Center(
                  child: Image.asset('images/E-stall.png',
                    width: MediaQuery.of(context).size.width/3,
                    height: MediaQuery.of(context).size.width/3,
                    fit: BoxFit.cover,),
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
                            labelText: 'আপনার পূর্ন নাম লিখুন *',
                            border: OutlineInputBorder()
                          ),
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
                              labelText: 'মোবাইল নাম্বার দিন *',
                              border: OutlineInputBorder()
                          ),
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
                              labelText: 'পাসওয়ার্ড লিখুন *',
                              border: OutlineInputBorder()
                          ),
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
                              labelText: 'আপনার ঠিকানা লিখুন *',
                              border: OutlineInputBorder()
                          ),
                          // ignore: missing_return
                          validator: (value){
                            if(value.isEmpty){
                              return 'This field must be required';
                            }
                          },
                          onSaved: (value){
                              profile.address=value;
                          },
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: RaisedButton(
                          child: Text('Sign Up',style: TextStyle(fontSize: 16,color: Colors.white.withOpacity(.8)),),
                          color: Colors.blue.withOpacity(.5),
                          onPressed: _submit,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
