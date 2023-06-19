import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/pages/sign_in_screen.dart';
import 'package:bank_sha/ui/widgets/buttons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  CarouselController carouselController = CarouselController();

  List<String> titles = [
    "Grow Your\nFinancial Today",
    "Build From\nZero to Freedom",
    "Start Together",
  ];

  List<String> subtitles = [
    "Our system is helping you to\nachieve a better goal",
    "We provide tips for you so that\nyou can adapt easier",
    "We will guide you to where\nyou wanted it too",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              items: [
                Image.asset(
                  "assets/img_onboarding1.png",
                ),
                Image.asset(
                  "assets/img_onboarding2.png",
                ),
                Image.asset(
                  "assets/img_onboarding3.png",
                ),
              ],
              options: CarouselOptions(
                height: 330,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                scrollPhysics: const BouncingScrollPhysics(),
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              carouselController: carouselController,
            ),
            const SizedBox(height: 80),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
              decoration: BoxDecoration(
                color: AppTheme.whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  // Title
                  Text(
                    titles[currentIndex],
                    style: AppTheme.blackTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: AppTheme.semiBold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 26),
                  // SubTitle
                  Text(
                    subtitles[currentIndex],
                    style: AppTheme.greyTextStyle.copyWith(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: currentIndex == 2 ? 38 : 50),
                  // Bullet Slider
                  currentIndex != 2
                      ? Row(
                          children: [
                            // Bullet 1
                            Container(
                              width: 12,
                              height: 12,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentIndex == 0
                                    ? AppTheme.blueColor
                                    : AppTheme.lightBackgroundColor,
                              ),
                            ),
                            // Bullet 2
                            Container(
                              width: 12,
                              height: 12,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentIndex == 1
                                    ? AppTheme.blueColor
                                    : AppTheme.lightBackgroundColor,
                              ),
                            ),
                            // Bullet 3
                            Container(
                              width: 12,
                              height: 12,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentIndex == 2
                                    ? AppTheme.blueColor
                                    : AppTheme.lightBackgroundColor,
                              ),
                            ),
                            const Spacer(),
                            // Button
                            CustomFilledButton(
                              width: 150,
                              title: "Continue",
                              onPressed: () {
                                carouselController.nextPage();
                              },
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            CustomFilledButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/sign-up', (route) => false);
                              },
                              title: "Get Started",
                            ),
                            CustomTextButton(
                              title: "Sign In",
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/sign-in', (route) => false);
                              },
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
