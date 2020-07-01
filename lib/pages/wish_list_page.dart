import 'package:estallecomerch/helpers/authentication_service.dart';
import 'package:estallecomerch/helpers/products_db_service.dart';
import 'package:estallecomerch/models/products_models_user.dart';
import 'package:estallecomerch/widgets/products_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class WishListPage extends StatefulWidget {
  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {

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
    return WillPopScope(
      onWillPop: (){
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Wish List'),
        ),
        body: Center(
          child: FutureBuilder(
            future: ProductsDBService.getAllFavouriteWithUser(email),
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
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: 10,),
                  Text('Wait..'),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
