import 'package:dio/dio.dart';


class DioHelper
{
 // https://newsapi.org/v2/top-headlines?country=eg&category=business&apikey=65f7f556ec76449fa7dc7c0069f040ca
 static late Dio ?dio ;
 static init() 
 {
  dio = Dio(
   BaseOptions(
    baseUrl: 'https://student.valuxapps.com/api/'  ,
    receiveDataWhenStatusError: true,
   ),
  ) ;
 }
 static Future<Response?> getData({
  required String url,
   Map<String, dynamic>? query,
  String lang = 'en',
  String? token
 })
 async {

  dio?.options.headers = {
   'Content-Type':'application/json',
   'lang' : lang,
   'Authorization' : token??''
  };

  return await dio?.get(
   url ,
   queryParameters:  query ,) ;
 }

 static Future<Response?> PostData({
  required String url,
  Map<String, dynamic>? query,
  required Map<String,dynamic> data,
  String lang = 'en',
  String? token
 })
 async {

  dio?.options.headers = {
   'Content-Type':'application/json',
   'lang' : lang,
   'Authorization' : token??''
  };
  return await dio?.post(
   url,
   queryParameters: query,
   data: data
  ) ;
 }



 static Future<Response?> PutData({
  required String url,
  Map<String, dynamic>? query,
  required Map<String,dynamic> data,
  String lang = 'en',
  String? token
 })
 async {

  dio?.options.headers = {
   'Content-Type':'application/json',
   'lang' : lang,
   'Authorization' : token??''
  };
  return await dio?.put(
      url,
      queryParameters: query,
      data: data
  ) ;
 }
}