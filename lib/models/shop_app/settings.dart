class SettingsModel {
  late bool status;
  late UserData? data;

  SettingsModel.fromjson(Map<String,dynamic> json)
  {
    status = json['status'];
    data = json['data'] == null ? null : UserData.fromjson(json['data'])  ;
  }
}

class UserData {

  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit ;
  late String token;

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