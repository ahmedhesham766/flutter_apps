import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shop_layout/cubit/cubit.dart';
import 'package:todo_app/layout/shop_layout/cubit/states.dart';
import 'package:todo_app/models/shop_app/category.dart';
import 'package:todo_app/models/shop_app/home.dart';
import 'package:todo_app/shared/components/components.dart';

import '../../../shared/styles/color.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      listener: (context,state){
        if(state is ShopChangeFavoriteSuccessState)
          {
            if(!state.model.status)
              {
                showToast(text: state.model.message, state: ToastState.ERROR);
              }
            else{
              showToast(text: state.model.message, state: ToastState.SUCCESS);
            }
          }
      },
      builder: (context,state)
      {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.homemodel != null && cubit.categorymodel != null,
            builder: (context) => productsBuilder(cubit.homemodel,cubit.categorymodel,context),
            fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder (HomeModel? model,CategoryModel? categorymodel,context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              CarouselSlider(
                  items: model?.data.banners.map((e) => Image(
                    image: NetworkImage('${e.image}'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )).toList(),
                  options: CarouselOptions(
                    height: 250,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,

                  )
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 100,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index) => buildCategoriesItems(categorymodel!.data.data[index]),
                          separatorBuilder: (context,index) => const SizedBox(
                            width: 10,
                          ),
                          itemCount: categorymodel!.data.data.length),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
            'New Products',
            style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w400
            ),
          ),
                  ],
                ),
              ),
              const SizedBox(
            height: 10.0,
          ),
              Container(
                color: Colors.grey,
                child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 1.0,
                        crossAxisSpacing: 1.0,
                          childAspectRatio: 1/1.51,
                          children: List.generate(model!.data.products.length,
                                  (index) => buildGridProducts(model.data.products[index],context)),
                    ),
              ),
        ],
    ),
  );
}

Widget buildCategoriesItems(DataModel model) => Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children:  [
    Container(
      padding:const EdgeInsets.symmetric(horizontal: 2.0),
      child:  Image(
          image: NetworkImage(model.image),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover
      ),
    ),
    Container(
      color: Colors.black.withOpacity(0.8),
      width: 100,
      child:  Text(
        model.name,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            color: Colors.white
        ),),
    )
  ],
);

Widget buildGridProducts(productsModel model,context) =>
   Container(
     color: Colors.white,
     child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(model.image),
              height: 200,
              width: double.infinity,
              //fit: BoxFit.cover,
            ),
            if(model.discount != 0)
                Container(
              color: Colors.red,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text('DISCOUNT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8.0
                  ),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 14.0
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: const TextStyle(
                        color: DefaultColor,
                        fontSize: 12.0
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  if(model.discount != 0)
                      Text(
                    '${model.old_price.round()}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10.0,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: (){
                        ShopCubit.get(context).ChangeFavourites(productID: model.id);

                  },
                      icon:  ShopCubit.get(context).favourites[model.id] == true ?
                      const Icon(Icons.favorite,color: DefaultColor) :
                      const Icon(Icons.favorite_outline)
                  )
                ],
              )
            ],
          ),
        ),


      ],
),
   );