// ignore_for_file: prefer_final_fields

import 'package:advanced_flutter_project/domian/models/slider_object.dart';
import 'package:advanced_flutter_project/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter_project/presentation/resources/color_manager.dart';
import 'package:advanced_flutter_project/presentation/resources/routes_manager.dart';
import 'package:advanced_flutter_project/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter_project/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

List<SliderObject> _list = _getSliderData();
PageController _pageController = PageController();
int currentPageIndex = 0;
List<SliderObject> _getSliderData() => [
      SliderObject(AppStrings.onBoardingTitle1, AppStrings.onBoardingSubTitle1,
          ImageAssets.onBoardingLogo1),
      SliderObject(AppStrings.onBoardingTitle2, AppStrings.onBoardingSubTitle2,
          ImageAssets.onBoardingLogo2),
      SliderObject(AppStrings.onBoardingTitle3, AppStrings.onBoardingSubTitle3,
          ImageAssets.onBoardingLogo3),
      SliderObject(AppStrings.onBoardingTitle4, AppStrings.onBoardingSubTitle4,
          ImageAssets.onBoardingLogo4),
    ];

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _list.length,
        onPageChanged: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return OnBoardingpage(sliderObject: _list[index]);
        },
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.loginRoute);
                },
                child: Text(
                  AppStrings.skip,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            _getIndecatorWidget(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: viewmodel.dispose()
    super.dispose();
  }
}

Widget _getIndecatorWidget() {
  return Container(
    color: ColorManager.primary,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            onTap: () {
              _pageController.animateToPage(_getPreviousPage(),
                  duration: const Duration(microseconds: 300),
                  curve: Curves.bounceOut);
            },
            child: SizedBox(
              width: AppSize.s20,
              height: AppSize.s20,
              child: SvgPicture.asset(
                ImageAssets.leftArrow,
              ),
            ),
          ),
        ),
        Row(
          children: [
            for (int i = 0; i < _list.length; i++)
              Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: _getProperCircle(i),
              )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            onTap: () {
              _pageController.animateToPage(_getNextPage(),
                  duration: const Duration(microseconds: 300),
                  curve: Curves.bounceInOut);
            },
            child: SizedBox(
              width: AppSize.s20,
              height: AppSize.s20,
              child: SvgPicture.asset(
                ImageAssets.rightArrow,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _getProperCircle(int index) {
  if (index == currentPageIndex) {
    return SvgPicture.asset(
      ImageAssets.hollowCirlce,
    );
  } else {
    return SvgPicture.asset(
      ImageAssets.solidCircle,
    );
  }
}

int _getPreviousPage() {
  int previousIndex = --currentPageIndex;
  if (previousIndex == -1) {
    previousIndex = _list.length - 1;
  }
  return previousIndex;
}

int _getNextPage() {
  int nextIndex = ++currentPageIndex;
  if (nextIndex == _list.length) {
    nextIndex = 0;
  }
  return nextIndex;
}

class OnBoardingpage extends StatelessWidget {
  final SliderObject sliderObject;
  const OnBoardingpage({Key? key, required this.sliderObject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.title != null ? sliderObject.title! : 'No Title',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.subTitle!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(sliderObject.image!),
      ],
    );
  }
}
