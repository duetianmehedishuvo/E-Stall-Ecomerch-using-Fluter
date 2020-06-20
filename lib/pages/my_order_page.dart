import 'package:estallecomerch/helpers/authentication_service.dart';
import 'package:estallecomerch/helpers/cart_service.dart';
import 'package:estallecomerch/helpers/provider/products_provider.dart';
import 'package:estallecomerch/models/choose_products_models.dart';
import 'package:estallecomerch/pages/payment_screen.dart';
import 'package:estallecomerch/widgets/choose_products_widgets.dart';
import 'package:estallecomerch/widgets/products_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class MyOrderPage extends StatefulWidget {
  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {

  int countNumber=0;
  AuthenticationService authenticationService;
  String email;
  double price=0.0;
  int cnt=0;

  ChooseProductModels chooseProductModels;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authenticationService=AuthenticationService();
    chooseProductModels=ChooseProductModels();
    AuthenticationService.getUserPhoneNumberByPreference().then((getEmail){
      setState(() {
        email=getEmail;

              Provider.of<ProductsProvider>(context,listen: false).getCount(getEmail);
              Provider.of<ProductsProvider>(context,listen: false).getTotalprice(getEmail);



      });
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    authenticationService=null;
  }

  @override
  Widget build(BuildContext context) {

    Provider.of<ProductsProvider>(context,listen: false).count;
    Provider.of<ProductsProvider>(context,listen: false).totalPrice;

    return WillPopScope(
      onWillPop: (){
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('My order'),
          actions: <Widget>[

            Stack(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.shopping_cart,color: Colors.white,),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context)=>PaymentScreen()
                    )).then((_){
                      setState(() {

                      });
                    });
                  },
                ),
                Positioned(
                  right: 10,
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(
                      maxHeight: 20,
                      maxWidth: 20,
                    ),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black
                    ),
                    child: Consumer<ProductsProvider>(
                      builder: (context,cart,child){
                        return FittedBox(child: Text(cart.count.toString()));
                      },
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        body: _center(context),

      ),
    );
  }

  Widget _center(BuildContext context){
    return Center(
      child: FutureBuilder(
        future: CartService.getAllChooseProducts(email),
        builder: (context,AsyncSnapshot<List<ChooseProductModels>> snapshot){
          if(snapshot.hasData){
            return Column(
              children: <Widget>[
                Expanded(
                  child: StaggeredGridView.countBuilder(crossAxisCount: 4,
                      itemCount: snapshot.data.length,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      itemBuilder: (context,index){

                        return ChooseProductWidget(snapshot.data[index]);
                      },
                      staggeredTileBuilder: (_)=>StaggeredTile.fit(2)),
                ),
                Container(
                  width: double.infinity,
                  height: 70,
                  color: Colors.cyan,
                  child: FlatButton.icon(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context)=>PaymentScreen()
                    )).then((_){
                      setState(() {

                      });
                    });
                  }, icon: Icon(Icons.card_travel,color: Colors.white.withOpacity(.5),),
                      label: Consumer<ProductsProvider>(
                        builder: (context,data,child){
                          return Text('CHECK OUT NOW \n৳ ${data.totalPrice}',style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),);
                        },
                      )),
                ),
              ],
            );
          }

          if(snapshot.hasError){
            print('Error Is: ${snapshot.error}');
            return Text('Failed to fetch data');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
