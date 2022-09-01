import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/styles/icon_broken.dart';

import '../../layout/shop_layout/cubit/cubit.dart';
import '../../modules/news_app/web_view/web_view.dart';
import '../styles/color.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextFormField({
  required IconData prefixIcon,
  required String label,
  IconData? suffixIcon,
  bool obscure = false,
  Color? color_icon,
  Color? color_label,
  TextInputType? textInputType ,
  TextEditingController? controller,
  VoidCallback? suffixOnPressed,
  FormFieldValidator<String>? validate,
  GestureTapCallback? onTap,
  ValueChanged<String>? onChanged,
  Color? color,
  ValueChanged<String>? onsubmit,
}) =>
    TextFormField(
      decoration: InputDecoration(filled: true,
        fillColor: color,
        prefixIcon: Icon(prefixIcon),
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: (suffixIcon != null)
            ? IconButton(
          icon: Icon(suffixIcon),
          onPressed: suffixOnPressed,
        )
            : null,
      ),
      obscureText: obscure,
      keyboardType: textInputType,
      controller: controller,
      validator: validate,
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onsubmit,

    );

IconData icon = Icons.check_box_outline_blank;

Widget buildtaskitems(Map mydata, context) =>Dismissible(
  key: Key(mydata['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(

      children:  [

         CircleAvatar(

          radius: 40.0,

          child: Text('${mydata['time']}'),

        ),

        const SizedBox(

          width:10.0,

        ),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(

                '${mydata['title']}',

                style: const TextStyle(

                  fontSize: 18.0,

                  fontWeight: FontWeight.bold,

                ),),

              Text(

                '${mydata['date']}',

                style: const TextStyle(

                    color: Colors.grey

                ),)

            ],

          ),

        ),

        const SizedBox(

          width:10.0,

        ),

        Column(
          children: [
            IconButton(

            onPressed: ()

            {

                  Appcubit.get(context).UpdateDatabase(status: "done", id: mydata['id']);
                  icon = Icons.check_box;
            },

                icon: Icon(

                  icon,

                  color: Colors.green,

                )),
          ],
        ),

        IconButton(

            onPressed: ()

            {

              Appcubit.get(context).UpdateDatabase(status: "archive", id: mydata['id']);

            },

            icon:const Icon(

              Icons.archive,

              color: Colors.black,

            ))



      ],

    ),

  ),
  onDismissed: (direction)
  {
    Appcubit.get(context).DeleteDatabase(id: mydata['id']);
  },
);

Widget tasksBuilder({
  required List<Map> tasks,
  required IconData icono
}) => ConditionalBuilder(
    condition: tasks.length > 0,
    builder: (context) => ListView.separated(
        itemBuilder: (context,index) => buildtaskitems(tasks[index],context),
        separatorBuilder: (context,index) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.black,
          ),
        )
        , itemCount: tasks.length),
    fallback: (context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Icon(
            icono,
            size: 100.0,
            color: Colors.grey,),
          const Text('No Tasks Yet, Please Add Some Tasks',
            style:TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            )
            ,)
        ],
      ),
    )
);

Widget buildArticleItem (article , context) => InkWell(
  onTap: ()
  {
    navigateTo(context, Web_Screen(article['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          width: 120.0,

          height: 120.0,

          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10.0),

              image:  DecorationImage(

                  image: NetworkImage(

                      (article['urlToImage'] != null)? '${article['urlToImage']}' : '${'no photo to this news'}'),

                  fit: BoxFit.cover

              )

          ),

        ),

        const SizedBox(

          width: 20.0,

        ),

        Expanded(

          child: Container(

            height: 120.0,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,

              children:  [

                Expanded(

                  child: Text('${article['title']}',

                    style: Theme.of(context).textTheme.bodyText1,

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                  ),

                ),

                Text(

                  '${article['publishedAt']}',

                  style: const TextStyle(

                    color: Colors.grey,

                  ),

                )

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);

Widget articleBuilder(list,{bool isSearch = false}) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context,index) => buildArticleItem(list[index],context),
        separatorBuilder: (context,index) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.black,
          ),
        ),
        itemCount: list.length),
    fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator())
);


void navigateTo(context, Widget) => Navigator.push(context,
  MaterialPageRoute(
    builder: (context) => Widget,
  ),
);

void navigateandfinish(context, Widget) => Navigator.pushAndRemoveUntil(context,
  MaterialPageRoute(
    builder: (context) => Widget,
  ),(route) {
      return false;
  },
);

void showToast({required String text,required ToastState state}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: ChooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastState
{
  SUCCESS,
  WARNING,
  ERROR
}

Color? ChooseToastColor(ToastState state)
{
  Color color;
  switch(state)
  {
    case ToastState.SUCCESS: 
      color = Colors.green;
      break;
    case ToastState.WARNING:
      color = Colors.yellow;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
  }

  return color;
}

Widget buildListItems ( model,context,{bool isOldPrice = true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(model.image),
              height: 120,
              width: 120,
              //fit: BoxFit.cover,
            ),
            if(model.discount != 0 && isOldPrice)
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
        const SizedBox(
          width: 20,
        ),
        Expanded(
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
              Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price}',
                    style: const TextStyle(
                        color: DefaultColor,
                        fontSize: 12.0
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  if(model.discount != 0 && isOldPrice)
                    Text(
                      '${model.oldPrice.round()}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
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
  ),
);

PreferredSizeWidget defaultAppBar(
{
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) => AppBar(
  leading: IconButton(
      onPressed: (){
        Navigator.pop(context);
      },
      icon: Icon(
        IconBroken.Arrow___Left_2
      )),
  titleSpacing: 0.0,
  title: Text(
      title!
  ),
  actions: actions,
);


// Widget buildArticleItem(article) => Padding(
//   padding: const EdgeInsets.all(20.0),
//   child: Row(
//     children: [
//       Container(
//         height: 120.0,
//         width: 120.0,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           image: DecorationImage(
//             image: NetworkImage('${article['urlToImage']}'),
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//       SizedBox(width: 20.0,),
//       Expanded(
//         child: SizedBox(
//           height: 120.0,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children:  [
//               Expanded(
//                 child: Text(
//                   '${article['title']}',
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis ,
//                 ),
//               ),
//               Text(
//                 '${article['publishedAt']}',
//                 style: TextStyle(
//                   color: Colors.grey,
//
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ],
//   ),
// );