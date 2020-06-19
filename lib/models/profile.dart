class Profile{

  String name;
  String email;
  String phoneNumber;
  String password;
  String address;
  String optionalNumber;

  Profile({this.name,this.email,this.phoneNumber, this.password, this.address,this.optionalNumber});

  Map<String,dynamic> toMap(){
    final map=<String,dynamic>{
      'name':name,
      'email':email,
      'phoneNumber':phoneNumber,
      'password':password,
      'address':address,
      'optionalNumber':optionalNumber,
    };
    return map;
  }

  Profile.fromMap(Map<String,dynamic> map){
    name=map['name'];
    email=map['email'];
    phoneNumber=map['phoneNumber'];
    password=map['password'];
    address=map['address'];
    optionalNumber=map['optionalNumber'];
  }


}