import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_app/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:todo_app/shared/network/local/cache_helper.dart';

import '../../../shared/components/components.dart';
import '../../../shared/styles/color.dart';

class BoardingModel {
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body
});
}


class onBoarding_Screen extends StatefulWidget {


  onBoarding_Screen({Key? key}) : super(key: key);

  @override
  State<onBoarding_Screen> createState() => _onBoarding_ScreenState();
}

class _onBoarding_ScreenState extends State<onBoarding_Screen> {
var BoardingController = PageController();

bool isLast = false;
void Submit()
{
  Cache_Helper.saveData(key: 'on_boarding', value: true)
      .then((value)
      {
        if(value)
          {
            navigateandfinish(context,ShopLoginScreen());
          }
      }
  );
}
  @override
  Widget build(BuildContext context) {
    List<BoardingModel> boarding = [
      BoardingModel(
          image: 'assets/images/on_boarding1.jpg',
          title: 'on Board1 Title',
          body: 'on Board1 Body'),
      BoardingModel(
          image: 'assets/images/on_boarding2.jpg',
          title: 'on Board2 Title',
          body: 'on Board2 Body'),
      BoardingModel(
          image: 'assets/images/on_boarding3.jpg',
          title: 'on Board3 Title',
          body: 'on Board3 Body')
    ];
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: ()
            {
              Submit();
            },
          child: const Text(
              'SKIP'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: BoardingController,
                onPageChanged: (index)
                {
                  if( index == boarding.length-1)
                    {
                      setState(()
                          {
                            isLast = true;
                          });
                    }
                  else{
                      setState(()
                      {
                        isLast = false;
                      });
                  }
                },
                itemBuilder: (context,index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,),

            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: BoardingController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: DefaultColor,
                      expansionFactor: 3,
                      dotWidth: 10,
                      dotHeight: 10,
                      spacing: 10
                    )
                ),
                const Spacer(),
                FloatingActionButton(
                  child: const Icon(Icons.arrow_forward_ios),
                    onPressed: (){
                      (isLast? Submit() :
                      BoardingController.nextPage(
                          duration: const Duration(
                            milliseconds: 700,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn) );
                    }
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem (BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
      Expanded(
        child: Image(
          image: AssetImage(model.image),
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
      Text(
        model.title,
        style: const TextStyle(
            fontSize: 24.0
        ),
      ),
      const SizedBox(
        height: 15.0,
      ),
      Text(
        model.body,
        style: const TextStyle(
            fontSize: 14.0
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
    ],
  );
}
