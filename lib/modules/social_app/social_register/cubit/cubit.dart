import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/social_app/social_user_model.dart';

import 'package:todo_app/modules/shop_app/shop_register/cubit/states.dart';
import 'package:todo_app/modules/social_app/social_register/cubit/states.dart';
import 'package:todo_app/shared/network/end_points.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

import '../../../../models/shop_app/login.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{

  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context) ;


  void UserRegister(
      {
        required String name,
        required String email,
        required String password,
        required String phone,
      }
      )
  {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password)
        .then((value) {
          print(value.user!.email);
          print(value.user!.uid);
          CreateUser(name: name, email: email, phone: phone, uid: value.user!.uid);
    }).catchError((error){
      print(error.toString());
      emit(SocialRegisterErrorState(error));
    });
  }

  void CreateUser(
  {
    required String name,
    required String email,
    required String phone,
    required String uid

})
  {
    Social_User_Model model = Social_User_Model(
      name: name,
      email: email,
      phone: phone,
      uId: uid,
      bio: "write your bio ...",
      cover: "https://www.pngkey.com/png/detail/230-2301779_best-classified-apps-default-user-profile.png",
      image: "https://www.pngkey.com/png/detail/230-2301779_best-classified-apps-default-user-profile.png",
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.collection('users').doc(uid).set(model.toMap()).
    then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }
  IconData suffix = Icons.visibility_off;
  bool isPassword = true;

  void ChangePasswordState()
  {
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    isPassword = !isPassword;
    emit(SocialRegisterPasswordVisibilityChangeState());
  }
}