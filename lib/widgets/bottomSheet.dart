
import 'package:estallecomerch/helpers/cart_service.dart';
import 'package:estallecomerch/helpers/payment_service.dart';
import 'package:estallecomerch/models/payment_get_email.dart';
import 'package:estallecomerch/models/payment_models.dart';
import 'package:estallecomerch/models/payment_product_models.dart';
import 'package:estallecomerch/models/profile.dart';
import 'package:estallecomerch/models/shop_models.dart';
import 'package:estallecomerch/pages/report_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class BottomSheetExample extends StatefulWidget {

  final PaymentModels paymentModels;
  final Profile profile;
  final List<PaymentProductModels> _paymentProductModel;

  BottomSheetExample(this.paymentModels, this.profile, this._paymentProductModel);

  @override
  _BottomSheetExampleState createState() => _BottomSheetExampleState();
}

class _BottomSheetExampleState extends State<BottomSheetExample> {
  final paymentKey=GlobalKey<FormState>();

  bool isContainer=true;
  PaymentProductModels paymentProductModels;
  PaymentGetEmail paymentGetEmail;
  ShopModels shopModels;

  PaymentModels paymentModelssub;
  String transitionID='';
  String paymentSystem='Bkash';
  String formattedDate;
  String formattedTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentProductModels=PaymentProductModels();
    paymentModelssub=PaymentModels();
    paymentGetEmail=PaymentGetEmail();
    shopModels=ShopModels();

    print(widget.paymentModels.price.toString());
    print(widget.profile.name);
    print(widget.profile.phoneNumber);
    print(widget.profile.address);
    print(widget.profile.email);

  }


  _orderSubmit(){

    paymentModelssub.profile=widget.profile;
    paymentModelssub.paymentProductModels=widget._paymentProductModel;
    paymentModelssub.price=widget.paymentModels.price;
    paymentModelssub.count=widget.paymentModels.count;


    paymentGetEmail.email=widget.profile.email;
    paymentGetEmail.date=formattedTime;


    if(isContainer){
      if(paymentKey.currentState.validate()){
        paymentKey.currentState.save();

        paymentModelssub.paymentMethod=paymentSystem;
        paymentModelssub.transactionNumber=transitionID;

          PaymentService.addPaymentEmail(paymentGetEmail, formattedDate);
          PaymentService.addPaymentTime(paymentGetEmail, formattedDate);
          PaymentService.addPaymentShopName(paymentModelssub, formattedDate,formattedTime);

          widget._paymentProductModel.forEach((paymentProduct) {
            setState(() {
              shopModels.name=paymentProduct.authName;
              CartService.addShopNameForPayment(paymentProduct, formattedDate, widget.profile.email, formattedTime);
              CartService.addShopName(shopModels, formattedDate);
            });
          });

          PaymentService.addPayment(paymentModelssub, formattedDate,formattedTime).then((_){

          }).catchError((error){
            print(error);
            Toast.show('Error', context);
          });

        Toast.show('Payment Successful', context);
        Navigator.of(context).pushReplacementNamed(ReportPages.route,arguments: paymentModelssub);


      }
    }else{
      paymentModelssub.paymentMethod=paymentSystem;
      paymentModelssub.transactionNumber=transitionID;
      
      PaymentService.addPaymentEmail(paymentGetEmail, formattedDate);
      PaymentService.addPaymentTime(paymentGetEmail, formattedDate);


      PaymentService.addPaymentShopName(paymentModelssub, formattedDate,formattedTime);

      widget._paymentProductModel.forEach((paymentProduct) {
        setState(() {
          shopModels.name=paymentProduct.authName;
          CartService.addShopNameForPayment(paymentProduct, formattedDate, widget.profile.email, formattedTime);
          CartService.addShopName(shopModels, formattedDate);
        });
      });

      PaymentService.addPayment(paymentModelssub, formattedDate,formattedTime).then((_){

      }).catchError((error){
        print(error);
        Toast.show('Error', context);
      });

      Toast.show('Payment Successful', context);
      Navigator.of(context).pushReplacementNamed(ReportPages.route,arguments: paymentModelssub);

    }
  }



  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    formattedDate = DateFormat('EEE d MMM').format(now);
    formattedTime = DateFormat('hh:mm:ss a').format(now);

    return Container(
      width: 500,
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: <Widget>[
            Text('Select Payment Method:'),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height:40,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(.8),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12)
                        ),
                      ),
                      margin: EdgeInsets.only(right: 2),
                      child: FlatButton(
                        child: Text('Cash On Delivery',style: TextStyle(
                            color: Colors.white
                        ),),
                        onPressed: (){
                          setState(() {
                            isContainer=false;
                            paymentSystem='Cash on delivery';
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height:40,
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12)
                        ),
                      ),
                      child: FlatButton(
                        child: Container(
                            child: Text('Bkash',style: TextStyle(
                              color: Colors.white,
                            ),)),
                        onPressed: (){
                          showAlertDialog(context, "step 1: Dial *247#" +
                              "\nstep 2:Select option 1(Send Money)" +
                              "\nstep 3: Enter this Number (01624054455)" +
                              "\nstep 4:Enter Amount" +
                              "\nstep 5:Enter Reference like(1234)" +
                              "\nstep6:Enter Your Pin number" +
                              "\nstep 7:Copy Transition number and Paste Below Box.", 'বিকাশের মাধ্যমে মূল্য পরিশোধ করার নিয়মঃ');

                          setState(() {
                            isContainer=true;
                            paymentSystem='Bkash';
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: isContainer?Form(
                key: paymentKey,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter your bkash Transaction id',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'This Field is should not be empty';
                    }
                    if(value.length<6){
                      return 'field length should 11 character';
                    }
                    return null;
                  },
                  onSaved: (value){
                    transitionID=value;
                  },
                ),
              ):Container(

              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(isContainer?'Selected Bkash Payment Option':'Selected Cash on delivery',style: TextStyle(
                  color: isContainer?Colors.pink:Colors.blue,
                ),)),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(.7),
                borderRadius: BorderRadius.circular(10)
              ),
              child: FlatButton(
                child: Text('Confirm Order',style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),),
                onPressed: _orderSubmit,
              ),
            ),
          ],
        ),
      ),
    );
  }


  ////// Alert Dialog Code
  showAlertDialog(BuildContext context, String message, String heading) {

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(heading),
      content: Text(message),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}