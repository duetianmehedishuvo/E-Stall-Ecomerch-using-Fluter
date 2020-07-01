import 'package:estallecomerch/helpers/authentication_service.dart';
import 'package:estallecomerch/helpers/cart_service.dart';
import 'package:estallecomerch/helpers/products_db_service.dart';
import 'package:estallecomerch/helpers/provider/products_provider.dart';
import 'package:estallecomerch/helpers/user_utils.dart';
import 'package:estallecomerch/models/choose_products_models.dart';
import 'package:estallecomerch/models/payment_models.dart';
import 'package:estallecomerch/models/payment_product_models.dart';
import 'package:estallecomerch/models/products_models_user.dart';
import 'package:estallecomerch/models/profile.dart';
import 'package:estallecomerch/pages/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ReportPages extends StatefulWidget {
  static final route='/reportScreen';
  PaymentModels paymentModels;

  @override
  _ReportPagesState createState() => _ReportPagesState();
}

class _ReportPagesState extends State<ReportPages> {


  String name='';
  String address='';
  String phoneNumber='';
  AuthenticationService authenticationService;
  String email1='';
  Profile profile1;
  ProductsUserId productsUserId;


  PaymentProductModels paymentProductModels;
  List<PaymentProductModels> _paymentProductModel=[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productsUserId=ProductsUserId();
    authenticationService=AuthenticationService();
    paymentProductModels=PaymentProductModels();
    profile1=Profile();

    AuthenticationService.getUserPhoneNumberByPreference().then((email){
      email1=email;
      setState(() {

        Provider.of<ProductsProvider>(context,listen: false).getCount(email);
        Provider.of<ProductsProvider>(context,listen: false).getTotalprice(email);

        authenticationService.getUserProfileByEmail(email).then((profile){
          setState(() {
            profile1=profile;
          });
        });

        CartService.getAllChooseProducts(email).then((productslist){
          setState(() {
            productslist.forEach((products) {
              paymentProductModels=PaymentProductModels();
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
  }

  _clearProduct(){

    UserUtils.saveUserSessionToPreference(false);
    UserUtils.getUserSessionUsingPref().then((value) {
      print(value.toString());
      widget.paymentModels.paymentProductModels.forEach((product) {
        setState(() {
          CartService.addtocartProductDelete(product.keyName, widget.paymentModels.profile.email).then((value){
            setState(() {

              ProductsDBService.getAllProducts().then((listOfProducts){
                listOfProducts.forEach((products) {
                  print('Delete  Method Call');
                  productsUserId.name=products.name;
                  productsUserId.nameKey=products.nameKey;
                  productsUserId.current_price=products.current_price;
                  productsUserId.last_price=products.last_price;
                  productsUserId.authorName=products.authorName;
                  productsUserId.imageUrl=products.imageUrl;
                  productsUserId.imageUrl2=products.imageUrl2;
                  productsUserId.imageUrl3=products.imageUrl3;
                  productsUserId.category=products.category;
                  productsUserId.description=products.description;
                  productsUserId.condition=products.condition;
                  productsUserId.quantity=products.quantity;

                  productsUserId.count=0;
                  productsUserId.favouriteCheck=false;

                  ProductsDBService.addProductWithUSER(productsUserId,widget.paymentModels.profile.email);
                  ProductsDBService.addProductBYCategoryWithUser(productsUserId, widget.paymentModels.profile.email);
                  ProductsDBService.addProductByAuthorWithUser(productsUserId, widget.paymentModels.profile.email);

                });
              });

              Provider.of<ProductsProvider>(context,listen: false).getCount(widget.paymentModels.profile.email);
              Provider.of<ProductsProvider>(context,listen: false).getTotalprice(widget.paymentModels.profile.email);
              Toast.show('Thanks For Parching Products', context);
              Navigator.of(context).pushReplacementNamed(HomeScreen.route);
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
    widget.paymentModels=ModalRoute.of(context).settings.arguments;

  }

  @override
  Widget build(BuildContext context) {

    Provider.of<ProductsProvider>(context,listen: false).count;
    Provider.of<ProductsProvider>(context,listen: false).totalPrice;

    return WillPopScope(
      onWillPop: (){
        UserUtils.saveUserSessionToPreference(false);
        Navigator.of(context).pushReplacementNamed(HomeScreen.route);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Report Page'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.home,color: Colors.white,),
              onPressed: (){
                _clearProduct();
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 260,
              color: Colors.blue.withOpacity(.2),
              child: Column(
                children: <Widget>[
                  Center(
                    child: FutureBuilder(
                      future: authenticationService.getUserProfileByEmail(email1),
                      builder: (context,AsyncSnapshot<Profile> snapshot){
                        if(snapshot.hasData){
                          return Column(
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
                                    Expanded(flex: 3,child: Text(''
                                        '${snapshot.data.name}'),),
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
                                    Expanded(flex: 3,child: Text('${snapshot.data.phoneNumber}'),),
                                  ],),
                                ),

                                Container(
                                  height: 46,
                                  color: Colors.blue.withOpacity(.2),
                                  padding: EdgeInsets.all(6),
                                  child: Row(children: <Widget>[
                                    Expanded(flex: 1,child: FittedBox(
                                      child: Text('Payment System:',style:TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),),
                                    ),),
                                    Expanded(flex: 3,child: Text(
                                      '  ${widget.paymentModels.paymentMethod}'
                                    ),),
                                  ],),
                                ),

                                Container(
                                  height: 46,
                                  color: Colors.blue.withOpacity(.2),
                                  padding: EdgeInsets.all(6),
                                  child: Row(children: <Widget>[
                                    Expanded(flex: 1,child: FittedBox(
                                      child: Text('Trans.Number:',style:TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),),
                                    ),),
                                    Expanded(flex: 3,child: Text(
                                      '  ${widget.paymentModels.transactionNumber}'
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
                                    Expanded(flex: 3,child: Text('${snapshot.data.address}'),),
                                  ],),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 5),
                                  width: double.infinity,
                                  child: Text('Products List',style: TextStyle(
                                    fontSize: 20,
                                    letterSpacing: 1.9
                                  ),),
                                ),
                              ],
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
                                  Expanded(child: Text(snapshot.data[index].current_price.toString())),
                                  Expanded(child: Text(snapshot.data[index].count.toString())),
                                  Expanded(child: Text(snapshot.data[index].totalPrice.toString())),

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
                          return FittedBox(child: Text('count: ${cart.count.toString()}'));
                        },
                      ),
                      Consumer<ProductsProvider>(
                        builder: (context,cart,child){
                          return FittedBox(child: Text('T-Price: ${cart.totalPrice+30} ৳',style: TextStyle(
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

          ],
        ),
      ),
    );
  }
}
