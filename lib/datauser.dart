class User{
  int id;
  String name;
  User({required this.id,required this.name});
  Map<String, dynamic> toMap(){
    return {'id':id,'name':name,};
  }
  User.fromMap(Map<String, dynamic> res):id=res["id"],name=res["name"];
}