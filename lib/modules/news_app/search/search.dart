import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/layout/news_layout/cubit/cubit.dart';
import 'package:todo_app/layout/news_layout/cubit/states.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

class Search extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Newscubit,NewsStates>(
        listener: (BuildContext context, Object? state) {  },
      builder: (BuildContext context, state) {
          var list = Newscubit.get(context).search;
          return Scaffold(
            appBar: AppBar(
              title:  Text(
                  'Search',
                style: Theme.of(context).textTheme.headline4
              ),
            ) ,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultTextFormField(
                    prefixIcon: Icons.search,
                    color: Appcubit.get(context).isDark? Colors.white : null ,
                      label: 'Search',
                      controller: searchController,
                      textInputType: TextInputType.text,
                      validate: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'Search must not be Empty';
                        }
                        return null;
                      },
                      onChanged: (value){
                        Newscubit.get(context).getSearch(value);
                      },
                  ),
                ),
                Expanded(child: articleBuilder(list))
              ],
            ),

          );

      },
    );
  }
}
