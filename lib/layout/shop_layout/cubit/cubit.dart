import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shop_layout/cubit/states.dart';
import 'package:todo_app/models/shop_app/Favourite.dart';
import 'package:todo_app/models/shop_app/category.dart';
import 'package:todo_app/models/shop_app/get_favourite.dart';
import 'package:todo_app/models/shop_app/home.dart';
import 'package:todo_app/models/shop_app/settings.dart';
import 'package:todo_app/modules/shop_app/categories/categories_screen.dart';
import 'package:todo_app/modules/shop_app/favorites/favorites_screen.dart';
import 'package:todo_app/modules/shop_app/products/prducts_screen.dart';
import 'package:todo_app/modules/shop_app/settings/settings_screen.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

import '../../../models/shop_app/login.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';

class ShopCubit extends Cubit<ShopState>
{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentindex =0;

  List<Widget> screens =[
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  void ChangeBottomNavItem(index)
  {
    currentindex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homemodel;

  Map<int , bool> favourites={};


  void GetHomeData()
  {
    emit(ShopHomeLoadingState());

    DioHelper.getData(
        url: HOME,
      token: cache_token,
    )
        .then((value)
    {
      homemodel = HomeModel.fromjson(value?.data);
      printFullText(homemodel!.data.banners[0].id.toString());
      printFullText(homemodel!.status.toString());
      homemodel!.data.products.forEach((element) {
        favourites.addAll(
            {
              element.id : element.infavorites
            }
        );
      });
      print(favourites.toString());
      emit(ShopHomeSuccessState(homemodel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopHomeErrorState(error.toString()));
    });
  }

  CategoryModel? categorymodel;

  void GetCategoryData()
  {
    emit(ShopHomeLoadingState());
    DioHelper.getData( url: CATEGORIES)
        .then((value)
    {
      categorymodel = CategoryModel.fromjson(value?.data);

      printFullText(categorymodel!.data.data.toString());
      emit(ShopCategoriesSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopCategoriesErrorState());
    });
  }

  FavouriteModel? favouriteModel;

  void ChangeFavourites(
  {
  required int productID
})
  {
    favourites[productID] = !favourites[productID]! ;
    emit(ShopChangeFavoriteState());
    DioHelper.PostData(
        url: FAVOURITES,
        data: {
          'product_id' : productID
        },
      token: cache_token
        )
        .then((value)
    {
      favouriteModel = FavouriteModel.fromjson(value?.data);
      print(favouriteModel!.status);
      print(favouriteModel!.message);
      if(!favouriteModel!.status)
        {
          favourites[productID] = !favourites[productID]!;
        }
      else
        {
          GetFavourites();
        }
      emit(ShopChangeFavoriteSuccessState(favouriteModel!));
    }).catchError((error)
    {
      favourites[productID] = !favourites[productID]!;
      print(error.toString());
      emit(ShopChangeFavouriteErrorState());
    });
  }
  
  GetFavoritesModel? getfav;
  
  void GetFavourites()
  {
    emit(ShopGetFavouritesLoadingState());
    DioHelper.getData(
        url: FAVOURITES,
      token: cache_token
    ).then((value)
    {
      getfav = GetFavoritesModel.fromJson(value!.data);
      emit(ShopGetFavouritesSuccessState());

    }).catchError((error){
      print(error.toString());
      emit(ShopChangeFavouriteErrorState());
    });
  }

  ShoploginModel? getprofile;
  
  void GetProfile()
  {
    emit(ShopGetProfileLoadingState());

    DioHelper.getData(
        url: PROFILE,
        token: cache_token)
        .then((value)
    {
      getprofile = ShoploginModel.fromjson(value?.data);
      //print(getprofile!.data!.name);
      emit(ShopGetProfileSuccessState(getprofile!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopGetProfileErrorState());
    });
  }



  void UpdateProfile(
  {
  required String name,
  required String email,
  required String phone,
})
  {
    emit(ShopUpdateProfileLoadingState());

    DioHelper.PutData(
        url: UPDATE_PROFILE,
        token: cache_token,
        data: {
          'name'  : name ,
          'email' : email,
          'phone' :  phone
        })
        .then((value)
    {
      getprofile = ShoploginModel.fromjson(value?.data);
      print(getprofile!.data!.name);
      emit(ShopUpdateProfileSuccessState(getprofile!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopGetProfileErrorState());
    });
  }

}