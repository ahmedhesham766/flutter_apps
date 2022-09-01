class ShoploginModel {
  late bool status ;
  dynamic? message;
  late UserData? data;

  ShoploginModel.fromjson(Map<String,dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] == null ? null : UserData.fromjson(json['data'])  ;
  }
}

class UserData {

  late int id;
  dynamic? name;
  dynamic? email;
  dynamic? phone;
  late String image;
   int? points;
   int? credit ;
   String? token;

  UserData.fromjson(Map<String,dynamic> json_data)
  {
    id = json_data['id'];
    name = json_data['name'];
    email = json_data['email'];
    phone = json_data['phone'];
    image = json_data['image'];
    points = json_data['points'];
    credit = json_data['credit'];
    token = json_data['token'];
  }

}