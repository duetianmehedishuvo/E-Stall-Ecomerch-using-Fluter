import 'package:estallecomerch/helpers/authentication_service.dart';
import 'package:estallecomerch/pages/homeScreen.dart';
import 'package:estallecomerch/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static final route='/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String email,password;

  AuthenticationService authenticationService;
  final _formKey=GlobalKey<FormState>();
  String uid;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email='';
    password='';
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
        uid=await authenticationService.login(email, password);
        if(uid!=null){
          authenticationService.saveUserPhoneNumberInPreference(email);
          Navigator.of(context).pushReplacementNamed(HomeScreen.route);
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
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  alignment: Alignment.center,
                  child: Text('Login Section',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                    ),)),
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
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Enter Your Phone Number',
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
                          email='$value@gmail.com';
                        },
                      ),
                      SizedBox(height: 10,),

                      TextFormField(
                        obscureText:true,
                        decoration: InputDecoration(
                            labelText: 'Enter Your valid Password al least 4 character',
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
                          password=value;
                        },
                      ),
                      SizedBox(height: 20,),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 16),),
                          color: Theme.of(context).primaryColor,
                          onPressed: _submit,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: FlatButton(
                          child: Text('Create a account'),
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=>SignUpScreen()
                            ));
                          },
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
