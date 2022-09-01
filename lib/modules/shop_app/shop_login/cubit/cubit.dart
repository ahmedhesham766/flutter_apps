import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/shop_app/shop_login/cubit/states.dart';
import 'package:todo_app/shared/network/end_points.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

import '../../../../models/shop_app/login.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates>
{

  ShopLoginCubit() : super(ShopLoginInitialState());

 static ShopLoginCubit get(context) => BlocProvider.of(context) ;

  ShoploginModel? loginmodel;

 void UserLogin(
 {
 required String email,
   required String password
}
     )
 {
   emit(ShopLoginLoadingState());
   DioHelper.PostData(
       url: Login,
       data:
       {
          'email' : email,
          'password': password
       }
   ).then((value)
   {
        print(value?.data);
        loginmodel = ShoploginModel.fromjson(value!.data);
        emit(ShopLoginSuccessState(loginmodel!));
   }).catchError((error)
   {
     print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
   });
 }

 IconData suffix = Icons.visibility_off;
 bool isPassword = true;

 void ChangePasswordState()
 {
   suffix = isPassword ? Icons.visibility : Icons.visibility_off;
   isPassword = !isPassword;
   emit(ShopLoginPasswordVisibilityChangeState());
 }
}