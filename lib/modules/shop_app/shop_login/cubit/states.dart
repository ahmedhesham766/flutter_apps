import '../../../../models/shop_app/login.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates{
  late ShoploginModel loginmodel;
  ShopLoginSuccessState(this.loginmodel);
}

class ShopLoginErrorState extends ShopLoginStates{
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopLoginPasswordVisibilityChangeState extends ShopLoginStates{}