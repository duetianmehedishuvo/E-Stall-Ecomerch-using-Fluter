import 'package:estallecomerch/helpers/authentication_service.dart';
import 'package:estallecomerch/helpers/products_db_service.dart';
import 'package:estallecomerch/models/products_models.dart';
import 'package:estallecomerch/models/products_models_user.dart';
import 'package:estallecomerch/widgets/products_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ShopProductsList extends StatefulWidget {

  final String shop_key;
  ShopProductsList(this.shop_key);

  @override
  _ShopProductsListState createState() => _ShopProductsListState();
}

class _ShopProductsListState extends State<ShopProductsList> {

  AuthenticationService authenticationService;
  String email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authenticationService=AuthenticationService();
    AuthenticationService.getUserPhoneNumberByPreference().then((mail){
      setState(() {
        email=mail;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shop_key),
      ),
      body: Center(
        child: FutureBuilder(
          future: ProductsDBService.getAllAuthorWithUser(widget.shop_key,email),
          builder: (context,AsyncSnapshot<List<ProductsUserId>> snapshot){
            if(snapshot.hasData){
              return StaggeredGridView.countBuilder(crossAxisCount: 4,
                  itemCount: snapshot.data.length,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  itemBuilder: (context,index)=>ProductsWidgets(snapshot.data[index]),
                  staggeredTileBuilder: (_)=>StaggeredTile.fit(2));
            }
            if(snapshot.hasError){
              return Text('Failed to fetch data');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
