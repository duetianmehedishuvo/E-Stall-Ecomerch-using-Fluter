import 'package:estallecomerch/helpers/authentication_service.dart';
import 'package:estallecomerch/helpers/cart_service.dart';
import 'package:estallecomerch/helpers/provider/products_provider.dart';
import 'package:estallecomerch/models/choose_products_models.dart';
import 'package:estallecomerch/models/payment_models.dart';
import 'package:estallecomerch/models/payment_product_models.dart';
import 'package:estallecomerch/models/profile.dart';
import 'package:estallecomerch/pages/profile_page.dart';
import 'package:estallecomerch/widgets/bottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  String name='';
  String address='';
  String phoneNumber='';
  AuthenticationService authenticationService;
  String email1='';
  Profile profile1;

  PaymentModels paymentModels;
  PaymentProductModels paymentProductModels;
  List<PaymentProductModels> _paymentProductModel=[];


  final _formKey=GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authenticationService=AuthenticationService();
    paymentModels=PaymentModels();
    paymentProductModels=PaymentProductModels();
    profile1=Profile();

    AuthenticationService.getUserPhoneNumberByPreference().then((email){
      email1=email;
      setState(() {
        authenticationService.getUserProfileByEmail(email).then((profile){
            setState(() {
              profile1=profile;
            });
        });

        CartService.getAllChooseProducts(email).then((productslist){
          setState(() {
            productslist.forEach((products) {
              paymentProductModels=PaymentProductModels();
              setState(() {
                paymentProductModels.name=products.name;
                paymentProductModels.count=products.count;
                paymentProductModels.current_price=products.current_price;
                paymentProductModels.price=products.totalPrice;
                paymentProductModels.keyName=products.nameKey;
                paymentProductModels.authName=products.authorName;
                print(products.name);
                _paymentProductModel.add(paymentProductModels);
              });
            });
          });
        });

      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    paymentModels.count=Provider.of<ProductsProvider>(context).count;
    paymentModels.price=Provider.of<ProductsProvider>(context).totalPrice+30;

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh,color: Colors.white,),
            onPressed: (){
              setState(() {

              });
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 219,
            color: Colors.blue.withOpacity(.2),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 35,
                  alignment: Alignment.topLeft,
                  child: FlatButton.icon(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context)=>ProfilePage()
                    )).then((_){
                      setState(() {

                      });
                    });
                  }, icon: Icon(Icons.edit), label: RichText(
                    text: new TextSpan(
                        text: 'Edit',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 17,
                            letterSpacing: .7
                        ),
                        children: <TextSpan>[
                          new TextSpan(
                            text: ' Your ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          new TextSpan(
                              text: 'Profile'
                          ),
                        ]
                    ),
                  )),
                ),//for

                Center(
                  child: FutureBuilder(
                    future: authenticationService.getUserProfileByEmail(email1),
                    builder: (context,AsyncSnapshot<Profile> snapshot){
                      if(snapshot.hasData){
                        return  Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 46,
                                color: Colors.blue.withOpacity(.2),
                                padding: EdgeInsets.all(6),
                                child: Row(children: <Widget>[
                                  Expanded(flex: 1,child: Text('Name:',style:TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),),),
                                  Expanded(flex: 3,child: TextFormField(
                                    initialValue: snapshot.data.name,
                                    decoration: InputDecoration(
                                        labelText: 'Your Name',
                                        border: OutlineInputBorder()
                                    ),
                                    onSaved: (value){
                                      paymentModels.profile.name=value;
                                      name=value;
                                    },
                                    keyboardType: TextInputType.text,

                                  ),),
                                ],),
                              ),

                              Container(
                                height: 46,
                                color: Colors.blue.withOpacity(.4),
                                padding: EdgeInsets.all(6),
                                child: Row(children: <Widget>[
                                  Expanded(flex: 1,child: Text('Mobile:',style:TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),),),
                                  Expanded(flex: 3,child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Phone Number',
                                        border: OutlineInputBorder()
                                    ),
                                    onSaved: (value){
                                      paymentModels.profile.phoneNumber=value;
                                    },
                                    keyboardType: TextInputType.phone,
                                    initialValue: snapshot.data.phoneNumber,
                                  ),),
                                ],),
                              ),

                              Container(
                                height: 46,
                                color: Colors.blue.withOpacity(.2),
                                padding: EdgeInsets.all(6),
                                child: Row(children: <Widget>[
                                  Expanded(flex: 1,child: Text('Mobile',style:TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),),),
                                  Expanded(flex: 3,child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Input Optional Number',
                                        border: OutlineInputBorder()
                                    ),onSaved: (value){
                                    paymentModels.profile.optionalNumber=value;
                                  },
                                    keyboardType: TextInputType.phone,
                                  ),),
                                ],),
                              ),

                              Container(
                                height: 46,
                                color: Colors.blue.withOpacity(.4),
                                padding: EdgeInsets.all(6),
                                child: Row(children: <Widget>[
                                  Expanded(flex: 1,child: Text('Address:',style:TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),),),
                                  Expanded(flex: 3,child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Address',
                                        border: OutlineInputBorder()
                                    ),
                                    onSaved: (value){
                                      paymentModels.profile.address=value;
                                    },
                                    keyboardType: TextInputType.text,
                                    initialValue: snapshot.data.address,
                                  ),),
                                ],),
                              ),
                            ],
                          ),
                        );
                      }
                      if(snapshot.hasError){
                        return Text('Data Face Problems');
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ),


                    ],
                  ),
                ),// edit profile



          Container(
            color:Colors.grey.withOpacity(.5),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(flex:2,child: Text('Name')),
                Expanded(child: Text('quantity')),
                Expanded(child: Text('price')),
                Expanded(child: Text('count')),
                Expanded(child: Text('P-price')),
              ],
            ),
          ),

          Expanded(
            child: Center(
              child: FutureBuilder(
                future: CartService.getAllChooseProducts(email1),
                builder: (context,AsyncSnapshot<List<ChooseProductModels>> snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context,index){
                          return Container(
                            color: Colors.blue.withOpacity(.1),
                            margin: EdgeInsets.only(bottom: 2),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Expanded(flex:2,child: Text(snapshot.data[index].name)),
                                Expanded(child: Text(snapshot.data[index].quantity)),
                                Expanded(child: Text('${snapshot.data[index].current_price} ৳')),
                                Expanded(child: Text(snapshot.data[index].count.toString())),
                                Expanded(child: Text('${snapshot.data[index].totalPrice} ৳')),

                              ],
                            ),
                          );
                        });
                  }

                  if(snapshot.hasError){
                    print('Error Is: ${snapshot.error}');
                    return Text('Failed to fetch data');
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ),

          Container(
            height: 30,
            alignment: Alignment.centerRight,
            width: double.infinity,
            color: Colors.blue.withOpacity(.1),
            padding: EdgeInsets.only(right: 16),
            child: Text('Delivery Charge: 30 ৳',style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500
            ),),
          ),

          Container(
            width: double.infinity,
            color: Colors.blue.withOpacity(.5),
            height: 40,
            child: FlatButton(
              highlightColor: Colors.black.withOpacity(.5),
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Consumer<ProductsProvider>(
                      builder: (context,cart,child){
                        return FittedBox(child: Text('items count: ${cart.count.toString()}'));
                      },
                    ),
                    Consumer<ProductsProvider>(
                      builder: (context,cart,child){
                        return FittedBox(child: Text('Total Price: ${cart.totalPrice+30} ৳',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: .8,
                          color: Colors.black.withOpacity(.8)
                        ),));
                      },
                    ),
                  ],
                ),
              ),
              onPressed: (){},
            ),
          ),

          Container(
            width: double.infinity,
            color: Colors.green.withOpacity(.7),
            height: 60,
            child: FlatButton(
              highlightColor: Colors.black.withOpacity(.5),
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'Proceed to Pay',style: TextStyle(color: Colors.white,fontSize: 20),
                ),
              ),
              onPressed: (){

            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context)=>SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
                child: BottomSheetExample(paymentModels,profile1,_paymentProductModel),
              ),
            ));
              },
            ),
          ),
        ],
      ),
    );
  }
}


