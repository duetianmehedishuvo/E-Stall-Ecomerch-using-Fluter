class PaymentGetEmail{
  String email;
  String date;

  PaymentGetEmail({this.email});

  Map<String,dynamic> toMap(){
    final map=<String,dynamic>{
      'email':email,
      'date':date,
    };
    return map;
  }

  PaymentGetEmail.fromMap(Map<String,dynamic> map){
    email=map['email'];
    date=map['date'];
  }

}