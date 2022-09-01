import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/shop_app/shop_login/cubit/states.dart';
import 'package:todo_app/modules/social_app/social_login/cubit/states.dart';
import 'package:todo_app/shared/network/end_points.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

import '../../../../models/shop_app/login.dart';


class SocialLoginCubit extends Cubit<SocialLoginStates>
{

  SocialLoginCubit() : super(SocialLoginInitialState());

 static SocialLoginCubit get(context) => BlocProvider.of(context) ;



 void UserLogin(
 {
 required String email,
   required String password
})
 {
   emit(SocialLoginLoadingState());
   FirebaseAuth.instance.signInWithEmailAndPassword(
       email: email,
       password: password)
       .then((value) {
         print(value.user!.email);
         print(value.user!.uid);
       emit(SocialLoginSuccessState(value.user!.uid));
   }).catchError((error){
     print(error.toString());
     emit(SocialLoginErrorState(error));
   });
 }

 IconData suffix = Icons.visibility_off;
 bool isPassword = true;

 void ChangePasswordState()
 {
   suffix = isPassword ? Icons.visibility : Icons.visibility_off;
   isPassword = !isPassword;
   emit(SocialLoginPasswordVisibilityChangeState());
 }
}