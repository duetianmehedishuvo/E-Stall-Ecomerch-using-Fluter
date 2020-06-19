import 'package:estallecomerch/helpers/products_db_service.dart';
import 'package:estallecomerch/models/products_models.dart';
import 'package:estallecomerch/pages/homeScreen.dart';
import 'package:estallecomerch/pages/shop_products_list.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop List'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search,color: Colors.white,),
            onPressed: (){
              showSearch(context: context, delegate: ShopSearch()).then((value){
                setState(() {
                  print(value);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=>ShopProductsList(value)
                  ));
                });
              });
            },
          )
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: ProductsDBService.getAllAuthorName(),
          builder: (context,AsyncSnapshot<List<Products>> snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                    return Card(
                      color: Colors.blue.withOpacity(.4),
                      child: ListTile(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=>ShopProductsList(snapshot.data[index].authorName)
                          ));
                        },
                        title: Text(snapshot.data[index].authorName,style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: .7
                        ),),
                      ),
                    );
                  });
            }
            if(snapshot.hasError){
              return Text('Data Fetch Problems');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class ShopSearch extends SearchDelegate{
  @override
  List<Widget> buildActions(BuildContext context) {
    return[
      IconButton(
        icon: Icon(Icons.cancel),
        onPressed: (){
          query='';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_left),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Text('Search Shop list is Empty'),
      ),
    );
  }
  @override
  Widget buildSuggestions(BuildContext context) {

    return Center(
      child: FutureBuilder(
        future: ProductsDBService.getAllAuthorName(),
        builder: (context,AsyncSnapshot<List<Products>> snapshot){
          if(snapshot.hasData){
            List<Products> suggestions=query==null?
            snapshot.data:
            snapshot.data.where((products)=>
                products.authorName.toLowerCase().startsWith(query.toLowerCase())).toList();

            return ListView.builder(
                itemCount: suggestions.length,
                itemBuilder: (context,index)=>ListTile(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>HomeScreen()
                    ));
                    query=suggestions[index].authorName;
                    close(context, query);
                  },
                  title: Text(suggestions[index].authorName),
                ));
          }

          if(snapshot.hasError){
            return new Text('Data Fetch problems');
          }
          return CircularProgressIndicator();
        },

      ),
    );
  }

}
