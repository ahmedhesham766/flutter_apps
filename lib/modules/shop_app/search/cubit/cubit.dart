import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/shop_app/search.dart';
import 'package:todo_app/modules/shop_app/search/cubit/states.dart';
import 'package:todo_app/shared/components/constants.dart';
import 'package:todo_app/shared/network/end_points.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates>
{
  ShopSearchCubit() : super(ShopSearchInitialState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchmodel;

  void Search(
  {
  required String text,
})
  {
    emit(ShopSearchLoadingState());
    DioHelper.PostData(
        url: SEARCH,
        data: {
          'text' : text
        },
        token: cache_token
    ).then((value) {
      searchmodel = SearchModel.fromJson(value?.data);
      emit(ShopSearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopSearchErrorState());
    });
  }
}