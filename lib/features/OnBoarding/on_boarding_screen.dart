import 'package:chat_gpt_task/image_assets.dart';
import 'package:chat_gpt_task/model/OnBoarding/on_boarding.dart';
import 'package:chat_gpt_task/features/Dashboard/dashboard_screen.dart';
import 'package:chat_gpt_task/features/OnBoarding/widgets/onboarding_item.dart';
import 'package:chat_gpt_task/shared/components/navigator.dart';
import 'package:chat_gpt_task/shared/style/color.dart';
import 'package:chat_gpt_task/shared/style/enum/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(),
      child: Scaffold(
        backgroundColor: isDark ? AppMainColors.secondColor : AppMainColors.whiteColor,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 10,
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: SvgPicture.asset(
                  Assets.imagesLogo,
                  width: 24,
                  fit: BoxFit.fitHeight,
                  color: isDark ? AppMainColors.greyColor : AppMainColors.darkColor,
                  height: 24.h,
                  placeholderBuilder: (_) => Shimmer.fromColors(
                    baseColor: Colors.grey[850]!,
                    highlightColor: Colors.grey[800]!,
                    child: Container(
                      height: 350.h,
                      color: isDark ? AppMainColors.greyColor : AppMainColors.greyColor.withOpacity(0.2),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Welcome to\n ChatGPT',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: isDark ? AppMainColors.whiteColor : AppMainColors.darkColor,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Ask anything, get your answer',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isDark ? AppMainColors.whiteColor : AppMainColors.darkColor,
                ),
              ),
              SizedBox(height: 60.h),
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (int index) {
                    if (index == onBoarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  controller: pageController,
                  itemBuilder: (context, index) => OnBoardingItem(
                    onBoardingModel: onBoarding[index],
                  ),
                  itemCount: onBoarding.length,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: onBoarding.length,
                    effect: WormEffect(
                      dotWidth: 28.w,
                      dotHeight: 2.h,
                      // dotColor: AppMainColors.whiteColor.withOpacity(0.2),
                      activeDotColor: AppMainColors.primaryColor,
                      spacing: 12,
                      radius: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  if (isLast) {
                    navigateAndFinish(context, const DashboardScreen());
                  } else {
                    pageController.nextPage(
                      duration: const Duration(
                        milliseconds: 780,
                      ),
                      curve: Curves.ease,
                    );
                  }
                },
                child: Container(
                  margin: const EdgeInsetsDirectional.only(
                    start: 20,
                    end: 20,
                    bottom: 20,
                  ),
                  height: 48.h,
                  width: 335.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppMainColors.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: isLast
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Let's Chat",
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AppMainColors.whiteColor,
                                  ),
                            ),
                            const SizedBox(width: 12),
                            SvgPicture.asset(
                              Assets.imagesArrowForward,
                              width: 10.w,
                              height: 12.h,
                            ),
                          ],
                        )
                      : Text(
                          'Next',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppMainColors.whiteColor,
                              ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}