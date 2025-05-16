import 'package:ajiapp/services/onboarding/controller/onboarding_controller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({super.key});

  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return Scaffold(
      body: Container(
        width: ScreenSize.width,
        height: ScreenSize.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Container(
            clipBehavior: Clip.hardEdge,
            margin: EdgeInsets.symmetric(
              vertical: ScreenSize.width * 0.01,
              horizontal: ScreenSize.width * 0.01,
            ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: PageView.builder(
                    controller: controller.pageController1,
                    onPageChanged: (index) {
                      controller.currentPage.value = index;

                      controller.pageController2.jumpToPage(index);
                    },
                    itemCount: controller.onboardingData.length,
                    itemBuilder: (context, index) {
                      return OnBoardingPageImage(
                        image: controller.onboardingData[index]['image']!,
                      );
                    },
                  ),
                ),
                Container(
                  width: ScreenSize.width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: white,
                        blurRadius: 20,
                        spreadRadius: 60,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.onboardingData.length,
                        (index) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            color: controller.currentPage.value == index
                                ? Colors.black
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller.pageController2,
                    itemCount: controller.onboardingData.length,
                    itemBuilder: (context, index) {
                      return OnBoardingPageDescription(
                        title: controller.onboardingData[index]['title']!,
                        subtitle: controller.onboardingData[index]['subtitle']!,
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => controller.skipOnboarding(),
                          child: Text(
                            "Skip >",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Obx(
                        () => Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: ScreenSize.width * 0.4,
                            child: ElevatedButton(
                              onPressed: controller.nextPage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ajired,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                controller.currentPage.value ==
                                        controller.onboardingData.length - 1
                                    ? "SignUp"
                                    : "Continue",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnBoardingPageImage extends StatelessWidget {
  final String image;

  const OnBoardingPageImage({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            image,
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }
}

class OnBoardingPageDescription extends StatelessWidget {
  final String title;
  final String subtitle;

  const OnBoardingPageDescription({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ajired,
            ),
          ),
          SizedBox(height: 20),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16, color: green, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
