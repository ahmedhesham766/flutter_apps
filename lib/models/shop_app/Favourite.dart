class FavouriteModel{
  late bool status;
  late String message;
  FavouriteModel.fromjson(Map<String,dynamic> json){
    status =  json['status'];
    message = json['message'];
  }
}