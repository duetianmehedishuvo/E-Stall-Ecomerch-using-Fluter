import 'package:estallecomerch/helpers/authentication_service.dart';
import 'package:estallecomerch/helpers/products_db_service.dart';
import 'package:estallecomerch/models/products_models.dart';
import 'package:estallecomerch/models/products_models_user.dart';
import 'package:estallecomerch/pages/my_order_page.dart';
import 'package:estallecomerch/widgets/products_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoryWiseProduct extends StatefulWidget {
  final String categoryName;
  final bool isListPage;
  CategoryWiseProduct({this.categoryName, this.isListPage});

  @override
  _CategoryWiseProductState createState() => _CategoryWiseProductState();
}

class _CategoryWiseProductState extends State<CategoryWiseProduct> {

  String email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthenticationService.getUserPhoneNumberByPreference().then((mail){
      setState(() {
        email=mail;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: FutureBuilder(
        future: ProductsDBService.getAllProductsByCATEGORYINUSER(widget.categoryName,email),
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
                  width: double.infinity,
                  height: 50,
                  color: Colors.blue,
                  child: FlatButton.icon(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context)=>MyOrderPage()
                    ));
                  }, icon: Icon(Icons.card_travel,color: Colors.white.withOpacity(.5),), label: Text('My Order',style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),)),
                )
              ],
            );
          }

          if(snapshot.hasError){
            return Text('Failed to fetch data');
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(height: 10,),
              Text('Wait..........'),
            ],
          );
        },
      ),
    );
  }
}
