class ContactUsModels{
  String name;
  String email;
  String phoneNumber;
  String message;
  String keyName;

  ContactUsModels({this.name, this.email, this.phoneNumber, this.message});

  Map<String,dynamic> tomap(){
    final map=<String,dynamic>{
      'name':name,
      'email':email,
      'phoneNumber':phoneNumber,
      'message':message,
      'keyName':keyName,
    };
    return map;
  }

  ContactUsModels.formMap(Map<String,dynamic> map){
    name=map['name'];
    email=map['email'];
    phoneNumber=map['phoneNumber'];
    message=map['message'];
    keyName=map['keyName'];
  }

}