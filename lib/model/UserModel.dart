class UserModel{
  String? email;
  String? password;
  // String? create_date;

  UserModel(this.email, this.password);
  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'email':email,
      'password': password,
      // 'create_date':create_date

    };
    return map;

  }
  UserModel.fromMap(Map<String,dynamic> map){
    email=map['email'];
    password = map['password'];
    // create_date= map['create_date'];

  }
  
}