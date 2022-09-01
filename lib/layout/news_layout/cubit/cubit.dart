import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/news_layout/cubit/states.dart';

import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

import '../../../modules/news_app/business/business.dart';
import '../../../modules/news_app/science/science.dart';
import '../../../modules/news_app/sports/sports.dart';

class Newscubit extends Cubit<NewsStates>
{
  Newscubit() : super(NewsInitialState());

  static Newscubit get(context) => BlocProvider.of(context);

  int currentindex =0;



  List<BottomNavigationBarItem> BottomItems =
  [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.business
        ) ,
        label: "Business"),
    const BottomNavigationBarItem(
        icon: Icon(
            Icons.sports_soccer_sharp
        ) ,
        label: "Sports"),
    const BottomNavigationBarItem(
        icon: Icon(
            Icons.science
        ) ,
        label: "Science"),
  ];

  List<Widget> screens=
  [
      Business_Screen(),
      Sports_Screen(),
      Science_Screen(),
  ];


  void ChangeNavBottom(index)
  {
    currentindex = index;
    if(index ==0)
      {
        getBusiness();
      }
    if(index == 1)
      {
        getSports();
      }
    else if(index == 2)
      {
        getScience();
      }
    emit(ChangeBottomNavBarState());
  }

  List<dynamic> business = [];
  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    if(business.length == 0)
    {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'business',
            'apikey':'65f7f556ec76449fa7dc7c0069f040ca',
          }).then((value)
      {
        business = value?.data['articles'] ;
        print(business[0]['title']);
        emit(NewsGetBusinessSuccessState());
      }
      ).catchError((onError)
      {
        print(onError.toString()) ;
        emit(NewsGetBusinessErrorState(onError.toString()));
      });
    }
    else{
      emit(NewsGetBusinessSuccessState());
    }

  }

  List<dynamic> sports = [];
  void getSports()
  {
    emit(NewsGetSportsLoadingState());
    if(sports.length == 0){
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country':'eg',
              'category':'sports',
              'apikey':'65f7f556ec76449fa7dc7c0069f040ca',
            }).then((value){
          sports = value?.data['articles'] ;
          emit(NewsGetSportsSuccessState());
        }
        ).catchError((onError)
        {
          print(onError.toString()) ;
          emit(NewsGetSportsErrorState(onError.toString()));
        });
      }
    else{
      emit(NewsGetSportsSuccessState());
    }

  }

  List<dynamic> science = [];

  void getScience()
  {
    emit(NewsGetScienceLoadingState());
    if(science.length == 0)
      {
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country':'eg',
              'category':'science',
              'apikey':'65f7f556ec76449fa7dc7c0069f040ca',
            }).then((value)
        {
          science = value?.data['articles'] ;
          emit(NewsGetScienceSuccessState());
        }
        ).catchError((onError)
        {
          print(onError.toString()) ;
          emit(NewsGetScienceErrorState(onError.toString()));
        });
      }
    else{
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());

      DioHelper.getData(
          url: 'v2/everything',
          query: {
            'q':'$value',
            'apikey':'65f7f556ec76449fa7dc7c0069f040ca',
          }).then((value)
      {
        search = value?.data['articles'] ;
        emit(NewsGetSearchSuccessState());
      }
      ).catchError((onError)
      {
        print(onError.toString()) ;
        emit(NewsGetSearchErrorState(onError.toString()));
      });

  }
}