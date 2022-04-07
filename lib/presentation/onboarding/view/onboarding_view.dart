// ignore_for_file: prefer_final_fields

import 'package:advanced_flutter_project/domian/models/slider_object.dart';
import 'package:advanced_flutter_project/presentation/onboarding/view_model/onboarding_view_model.dart';
import 'package:advanced_flutter_project/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter_project/presentation/resources/color_manager.dart';
import 'package:advanced_flutter_project/presentation/resources/routes_manager.dart';
import 'package:advanced_flutter_project/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter_project/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

PageController _pageController = PageController();
OnBoardingViewModel _viewModel = OnBoardingViewModel();

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        } else {
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
              itemCount: snapshot.data!.numberOfSliders,
              onPageChanged: (index) {
                _viewModel.onPageChanged(index);
              },
              itemBuilder: (context, index) {
                return OnBoardingpage(
                    sliderObject: snapshot.data!.sliderObject);
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
                        Navigator.pushReplacementNamed(
                            context, Routes.loginRoute);
                      },
                      child: Text(
                        AppStrings.skip,
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  _getIndecatorWidget(snapshot.data),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

Widget _getIndecatorWidget(SliderViewObject? sliderViewObject) {
  return Container(
    color: ColorManager.primary,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            onTap: () {
              _pageController.animateToPage(_viewModel.goPrevious(),
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
            for (int i = 0; i < sliderViewObject!.numberOfSliders; i++)
              Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: _getProperCircle(i, sliderViewObject.currentIndex),
              )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            onTap: () {
              _pageController.animateToPage(_viewModel.goNext(),
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

Widget _getProperCircle(int index, int? currentIndex) {
  if (index == currentIndex) {
    return SvgPicture.asset(
      ImageAssets.hollowCirlce,
    );
  } else {
    return SvgPicture.asset(
      ImageAssets.solidCircle,
    );
  }
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
