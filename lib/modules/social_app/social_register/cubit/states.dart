import '../../../../models/shop_app/login.dart';

abstract class SocialRegisterStates{}

class SocialRegisterInitialState extends SocialRegisterStates{}

class SocialRegisterLoadingState extends SocialRegisterStates{}

class SocialRegisterSuccessState extends SocialRegisterStates{

}

class SocialRegisterErrorState extends SocialRegisterStates{
  late final String error;
  SocialRegisterErrorState(this.error);
}

class SocialRegisterPasswordVisibilityChangeState extends SocialRegisterStates{

}

class SocialCreateUserSuccessState extends SocialRegisterStates{

}

class SocialCreateUserErrorState extends SocialRegisterStates{
  late final String error;
  SocialCreateUserErrorState(this.error);
}