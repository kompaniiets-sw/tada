import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tada/navigation_menu.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  int currentPageIndex = 0;

  Future<void> _onIntroEnd(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false);

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const NavigationMenu()),
      );
    }
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyAlignment: Alignment.topLeft,
      titlePadding: EdgeInsets.only(top: 600),
      bodyPadding: EdgeInsets.fromLTRB(16.0, 20, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    List<PageViewModel> pages = [
      PageViewModel(
        title: "Take Control of Your Time",
        body:
            "Track how you spend your day and discover opportunities to improve your schedule.",
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: "Boost Your Productivity",
        body:
            "Analyze your efficiency, set clear goals, and achieve more without burnout.",
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: "Stay Motivated with Gamification",
        body:
            "Earn rewards for completing tasks and stay motivated every single day.",
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: "Ready to Begin?",
        body:
            "Step into a world of productivity and balance. Tap the button below to get started!",
        decoration: pageDecoration,
      ),
    ];

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: false,
      showBackButton: false,
      showSkipButton: false,
      showNextButton: false,
      showDoneButton: false,
      done: const Text("Готово", style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () => _onIntroEnd(context),
      pages:
          pages
              .asMap()
              .entries
              .map(
                (entry) => PageViewModel(
                  title: entry.value.title,
                  body: entry.value.body,
                  decoration: entry.value.decoration,
                  footer: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        if (entry.key == pages.length - 1) {
                          _onIntroEnd(context);
                        } else {
                          introKey.currentState?.next();
                        }
                      },
                      child: Text(
                        entry.key == pages.length - 1 ? 'Done' : 'Continue',
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
      onChange: (index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
