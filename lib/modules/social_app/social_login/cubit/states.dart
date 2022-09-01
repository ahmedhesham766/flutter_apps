import '../../../../models/shop_app/login.dart';

abstract class SocialLoginStates{}

class SocialLoginInitialState extends SocialLoginStates{}

class SocialLoginLoadingState extends SocialLoginStates{}

class SocialLoginSuccessState extends SocialLoginStates{
  late final String uid;
  SocialLoginSuccessState(this.uid);
}

class SocialLoginErrorState extends SocialLoginStates{
  final String error;
  SocialLoginErrorState(this.error);
}

class SocialLoginPasswordVisibilityChangeState extends SocialLoginStates{}