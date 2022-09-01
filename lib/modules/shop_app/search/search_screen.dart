import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/shop_app/search/cubit/cubit.dart';
import 'package:todo_app/modules/shop_app/search/cubit/states.dart';
import 'package:todo_app/shared/components/components.dart';

import '../../../layout/shop_layout/cubit/cubit.dart';
import '../../../layout/shop_layout/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopState>(
          listener: (context,state) {},
          builder: (context,state) {
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultTextFormField(
                          prefixIcon: Icons.search,
                          label: "Search",
                          controller: searchController,
                          textInputType: TextInputType.text,
                          validate: (value)
                          {
                            if(value!.isEmpty)
                              {
                                return "I think u must type what u search about first";
                              }
                            return null;
                          },
                          onsubmit: (text){
                            ShopSearchCubit.get(context).Search(text: text);
                          }
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      if(state is ShopSearchLoadingState) LinearProgressIndicator(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      if(state is ShopSearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context,index) => buildListItems(ShopSearchCubit.get(context).searchmodel!.data!.data![index], context,isOldPrice: false),
                              separatorBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 1.0,
                                  width: double.infinity,
                                  color: Colors.black,
                                ),
                              ),
                              itemCount: ShopSearchCubit.get(context).searchmodel!.data!.data!.length),
                        )
                    ],
                  ),
                ),
              ),
            );
          },
    );
  }

}