import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:estallecomerch/helpers/products_db_service.dart';
import 'package:estallecomerch/models/products_models.dart';
import 'package:estallecomerch/models/products_models_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class AddProductsScreen extends StatefulWidget {
  @override
  _AddProductsScreenState createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {

  String _myActivity;
  String _myActivityResult;
  final formKey =GlobalKey<FormState>();
  String _authorName='';

  Products products=Products();
  ProductsUserId productsUserId=ProductsUserId();

  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      products.last_price=0;
      productsUserId.last_price=0;

      products.condition='Add To Cart';
      productsUserId.condition='Add To Cart';

      productsUserId.price=0;
      productsUserId.count=0;

      if(_authorName.isEmpty){
        products.authorName='estall';
        productsUserId.authorName='estall';
      }else{
        products.authorName=_authorName;
        productsUserId.authorName=_authorName;
      }

      ProductsDBService.addProduct(products).then((_){

        ProductsDBService.addProductByAuthor(products);
        ProductsDBService.addProductBYCategory(products);

        ProductsDBService.addProductByAuthorName(products);

        setState(() {
          _myActivityResult = _myActivity;
          Toast.show('Save Successful', context);
        });
      }).catchError((error){
        Toast.show('Save To Failed', context);
        print(error);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Products'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Product name *',
                                border: OutlineInputBorder()
                            ),
                            validator: (value){
                              if(value.isEmpty){
                                return 'Products name should not be empty';
                              }
                              return null;
                            },
                            onSaved: (value){
                            products.name=value;
                            productsUserId.name=value;
                            },
                          ),
                          SizedBox(height: 10,),

                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Product Key name',
                                border: OutlineInputBorder()
                            ),
                            onSaved: (value){
                              products.nameKey=value;
                              productsUserId.nameKey=value;
                            },
                          ),
                          SizedBox(height: 10,),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                                color: Colors.white.withOpacity(.9),
                              border: Border.all(color: Colors.grey)
                            ),
                            child: DropDownFormField(
                              titleText: 'Category',
                              hintText: 'Please choose one Category *',
                              value: _myActivityResult,
                              validator: (value){
                                if(value==null){
                                  return 'select a item';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                setState(() {
                                  products.category = value;
                                  productsUserId.category = value;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  _myActivityResult = value;
                                });
                              },
                              dataSource: [
                                {
                                  "display": "Groceries",
                                  "value": "groceries",
                                },
                                {
                                  "display": "Drink & Desert",
                                  "value": "drink_desert",
                                },
                                {
                                  "display": "Gas Cylinder",
                                  "value": "gas_cylinder",
                                },
                                {
                                  "display": "Mask & Sanitiser",
                                  "value": "mask_sanitiser",
                                },
                                {
                                  "display": "Fashion",
                                  "value": "fashion",
                                },
                                {
                                  "display": "Cosmetics",
                                  "value": "cosmetics",
                                },
                                {
                                  "display": "Electronic",
                                  "value": "electronic",
                                },
                                {
                                  "display": "Furniture",
                                  "value": "furniture",
                                },
                              ],
                              textField: 'display',
                              valueField: 'value',
                            ),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: 'Price *',
                                border: OutlineInputBorder()
                            ),
                            validator: (value){
                              if(value.isEmpty){
                                return 'Price should not be empty';
                              }
                              return null;
                            },
                            onSaved: (value){
                              products.current_price=double.parse(value);
                              productsUserId.current_price=double.parse(value);
                            },
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Quantity *',
                                border: OutlineInputBorder()
                            ),
                            validator: (value){
                              if(value.isEmpty){
                                return 'Quantity Filled  should not be empty';
                              }
                              return null;
                            },
                            onSaved: (value){
                              products.quantity=value;
                              productsUserId.quantity=value;
                            },
                          ),SizedBox(height: 10,),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                labelText: 'Author name default estall',
                                border: OutlineInputBorder()
                            ),
                            onSaved: (value){
                            _authorName=value;
                            },
                          ),SizedBox(height: 10,),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Image Url',
                                border: OutlineInputBorder()
                            ),
                            onSaved: (value){
                            products.imageUrl=value;
                            productsUserId.imageUrl=value;
                            },
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                labelText: 'Product Description',
                                border: OutlineInputBorder()
                            ),
                            onSaved: (value){
                              products.description=value;
                              productsUserId.description=value;
                            },
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.blue,
              padding: EdgeInsets.all(8),
              child: FlatButton(
                child: Text('Save',style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,

                ),),
                onPressed: _saveForm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
