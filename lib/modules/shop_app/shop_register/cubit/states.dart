import '../../../../models/shop_app/login.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates{
  late ShoploginModel loginmodel;
  ShopRegisterSuccessState(this.loginmodel);
}

class ShopRegisterErrorState extends ShopRegisterStates{
  late final String error;
  ShopRegisterErrorState(this.error);
}

class ShopRegisterPasswordVisibilityChangeState extends ShopRegisterStates{

}