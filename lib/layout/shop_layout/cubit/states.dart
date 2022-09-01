import 'package:todo_app/layout/shop_layout/shop_layouy.dart';
import 'package:todo_app/models/shop_app/Favourite.dart';
import 'package:todo_app/models/shop_app/home.dart';
import 'package:todo_app/models/shop_app/login.dart';

import '../../../models/shop_app/settings.dart';

abstract class ShopState{}

class ShopInitialState extends ShopState{}

class ShopChangeBottomNavState extends ShopState{}

class ShopHomeLoadingState extends ShopState{}


class ShopHomeSuccessState extends ShopState{
  late HomeModel homemodel;
  ShopHomeSuccessState(this.homemodel);
}


class ShopHomeErrorState extends ShopState{
  final String error;
  ShopHomeErrorState(this.error);
}

class ShopCategoriesSuccessState extends ShopState{

}

class ShopCategoriesErrorState extends ShopState{}

class ShopChangeFavoriteState extends ShopState{}

class ShopChangeFavoriteSuccessState extends ShopState{
  late FavouriteModel model;
  ShopChangeFavoriteSuccessState(this.model);
}

class ShopChangeFavouriteErrorState extends ShopState{}

class ShopGetFavouritesSuccessState extends ShopState{}

class ShopGetFavouritesLoadingState extends ShopState{}

class ShopGetFavoritesErrorState extends ShopState{}

class ShopGetProfileLoadingState extends ShopState{}

class ShopGetProfileSuccessState extends ShopState{
  late ShoploginModel model;
  ShopGetProfileSuccessState(this.model);
}

class ShopGetProfileErrorState extends ShopState{}

class ShopUpdateProfileLoadingState extends ShopState{}

class ShopUpdateProfileSuccessState extends ShopState{
  late ShoploginModel model;
  ShopUpdateProfileSuccessState(this.model);

}

class ShopUpdateProfileErrorState extends ShopState{}


