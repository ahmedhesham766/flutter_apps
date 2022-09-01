import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/layout/news_layout/cubit/cubit.dart';
import 'package:todo_app/layout/news_layout/cubit/states.dart';
import 'package:todo_app/layout/news_layout/news_screen.dart';
import 'package:todo_app/layout/shop_layout/cubit/cubit.dart';
import 'package:todo_app/layout/shop_layout/shop_layouy.dart';
import 'package:todo_app/layout/social_layout/social_layout.dart';
import 'package:todo_app/layout/todo_layout/home_screen_layout.dart';
import 'package:todo_app/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:todo_app/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:todo_app/modules/social_app/social_login/social_login_screen.dart';
import 'package:todo_app/shared/bloc_observer.dart';
import 'package:todo_app/shared/components/constants.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/network/local/cache_helper.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';
import 'package:todo_app/shared/styles/theme.dart';

import 'layout/social_layout/cubit/cubit.dart';
import 'modules/native_code.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  BlocOverrides.runZoned(
        ()  async {
      DioHelper.init();
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();

      var token = FirebaseMessaging.instance.getToken();

      print(token);

      FirebaseMessaging.onMessage.listen((event) {
        print("ssss");
        print(event.data.toString());
      });


      await Cache_Helper.init();

      bool? cache_isDark = Cache_Helper.GetData(key: 'isDark');

      bool? cache_on_boarding = Cache_Helper.GetData(key: 'on_boarding');

       cache_token = Cache_Helper.GetData(key: 'token');

       uid = Cache_Helper.GetData(key: 'uid');

      Widget screenState;

     /* if(cache_on_boarding != null)
        {
          if(cache_token != null)
            {
              screenState = ShopLayout();
            }
          else{
            screenState = ShopLoginScreen();
          }
        }
      else{
        screenState = onBoarding_Screen();
      }*/
      if(uid != null)
        {
          screenState = Social_Layout_Screen();
        }
      else{
        screenState = Social_Login_screen();
      }
      print("dark ?");
      print (cache_isDark);
      print("on boarding ?");
      print(cache_on_boarding);
      print("token:");
      print(cache_token);
      print("uId:");
      print(uid);

      runApp( MyApp(isDark: cache_isDark,screenState: screenState,));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {

   bool? isDark;
   Widget? screenState;
   MyApp({this.isDark, this.screenState}) ;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => Appcubit()..changeAppMode(
                fromshared: false
            )),
        BlocProvider(
        create: (BuildContext context) => Newscubit()..getBusiness()..getSports()..getScience(),
        ),
          BlocProvider(
          create: (BuildContext context) => SocialCubit()..GetUserData()..getPosts(),
          )
      ],

        child: BlocConsumer<Appcubit,Appstates>(
          listener: (context,state){},
          builder: (context,state){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: LightTheme,
              darkTheme: DarkTheme,
              themeMode: Appcubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              home: NativeCodeScreen(),
            );
          },

        ),
      );

  }
}
