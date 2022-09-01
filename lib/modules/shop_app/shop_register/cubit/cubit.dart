import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/modules/shop_app/shop_register/cubit/states.dart';
import 'package:todo_app/shared/network/end_points.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

import '../../../../models/shop_app/login.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{

  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context) ;

  ShoploginModel? loginmodel;

  void UserRegister(
      {
        required String name,
        required String email,
        required String password,
        required String phone,
      }
      )
  {
    emit(ShopRegisterLoadingState());
    DioHelper.PostData(
        url: REGISTER,
        data:
        {
          'name' : name,
          'email' : email,
          'password': password,
          'phone'  : phone
        }
    ).then((value)
    {
      print(value?.data);
      loginmodel = ShoploginModel.fromjson(value!.data);
      emit(ShopRegisterSuccessState(loginmodel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off;
  bool isPassword = true;

  void ChangePasswordState()
  {
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    isPassword = !isPassword;
    emit(ShopRegisterPasswordVisibilityChangeState());
  }
}