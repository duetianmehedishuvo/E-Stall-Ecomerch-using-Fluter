import 'package:estallecomerch/helpers/authentication_service.dart';
import 'package:estallecomerch/helpers/products_db_service.dart';
import 'package:estallecomerch/helpers/provider/products_provider.dart';
import 'package:estallecomerch/models/products_models_user.dart';
import 'package:estallecomerch/pages/my_order_page.dart';
import 'package:estallecomerch/pages/check_out_screen.dart';
import 'package:estallecomerch/widgets/products_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ProductScreen extends StatefulWidget {
  static final route='/productScreen';
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  String useremail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthenticationService.getUserPhoneNumberByPreference().then((email){
      setState(() {
        useremail=email;
      });
    });


  }

  @override
  Widget build(BuildContext context) {

    Provider.of<ProductsProvider>(context).count;

    return Center(
      child: FutureBuilder(
        future: ProductsDBService.getAllProductsWithUser(useremail),
        builder: (context,AsyncSnapshot<List<ProductsUserId>> snapshot){
          if(snapshot.hasData){
            return Column(
              children: <Widget>[
                Expanded(
                  child: StaggeredGridView.countBuilder(crossAxisCount: 4,
                      itemCount: snapshot.data.length,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      itemBuilder: (context,index)=>ProductsWidgets(snapshot.data[index]),
                      staggeredTileBuilder: (_)=>StaggeredTile.fit(2)),
                ),
                Container(
                  child: Consumer<ProductsProvider>(
                    builder: (context,cart,child){
                      return cart.count==0?Container():
                      Container(
                        width: double.infinity,
                        height: 60,
                        color: Colors.green.withOpacity(.7),
                      child: FlatButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                      Text('Place Order',style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),),

                        Consumer<ProductsProvider>(
                              builder: (context,data,child){
                                return Container(
                                  padding: EdgeInsets.only(right: 15),
                                  child: Text('৳ ${data.totalPrice}',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),),
                                );
                              },
                            ),
                          ],
                        ),
                        onPressed: (){
                          if(cart.count==0){
                            Toast.show('Please select items', context);
                          }else if(cart.totalPrice<200){
                            Toast.show('Warning : আপনার অর্ডারটি সম্পূর্ণ করতে নূন্যতম ২০০ টাকার পণ্য লাগবে.', context);
                          }
                          else{
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=>CheckOutPages()
                            )).then((_){
                              setState(() {

                              });
                            });
                          }

                        },
                      ),
                      );
                    },
                  ),
                ),

              ],
            );
          }
          if(snapshot.hasError){
            return Text('Failed to fetch data');
          }
          return CircularProgressIndicator();
        },
      ),
    );

  }
}
