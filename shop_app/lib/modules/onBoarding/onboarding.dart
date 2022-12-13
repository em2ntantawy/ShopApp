import 'package:flutter/material.dart';
import 'package:shop_app/models/on_boarding_model.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../network/local/cache_helper.dart';

class onBoardingScreen extends StatefulWidget {
  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;
  // void submit() {
  //   CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
  //     navigateAndFinish(context, Login());
  //   });

  List<onBoardingModel> boarding = [
    onBoardingModel(
        image: 'images/T1.jpeg',
        title: 'Buy any food from your favourite restaurant',
        body:
            'We are constantly adding your favourite restaurant throughout the territory and around your area carefully selected '),
    onBoardingModel(
        image: 'images/T2.jpeg',
        title: 'Get exclusive offer from your favourite restaurant',
        body:
            'We are constantly bringing your favourite food from your favourite restaurant with various  types of offers'),
    onBoardingModel(
        image: 'images/T3.jpeg',
        title: 'Get food delivery to your doorstep asap',
        body:
            'We have young and professionaly delivery team that will bring your food as soon as possible to your doorstep')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                CacheHelper.saveData(key: 'onboard', value: true).then((value) {
                  if (value) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  }
                });
              },
              child: Text(
                'SKIP',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    print('Last');
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    BuildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                      spacing: 5.0,
                      radius: 4.0,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      expansionFactor: 4,

                      // paintStyle: PaintingStyle.stroke,
                      //strokeWidth: 1.5,
                      dotColor: Colors.grey,
                      activeDotColor: Color.fromARGB(255, 83, 144, 118)),
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Color.fromARGB(255, 83, 144, 118),
                  onPressed: () {
                    if (isLast) {
                      CacheHelper.saveData(key: 'onboard', value: true)
                          .then((value) {
                        if (value) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        }
                      });
                    } else {
                      boardController.nextPage(
                          duration: Duration(
                            milliseconds: 250,
                          ),
                          curve: Curves.bounceInOut);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
