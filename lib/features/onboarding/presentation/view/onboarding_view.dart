import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquor_ordering_system/features/onboarding/presentation/viewmodel/onboarding_view_model.dart';

class OnboardingView extends ConsumerStatefulWidget {
  const OnboardingView({super.key});

  @override
  ConsumerState<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView> {
  @override
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingPages.length,
            itemBuilder: (context, index) {
              return OnboardingPage(
                title: onboardingPages[index].title,
                description: onboardingPages[index].description,
                imageUrl: onboardingPages[index].imageUrl,
              );
            },
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
          ),
          Positioned(
            top: 40,
            right: 20,
            child: Visibility(
              visible: _currentPageIndex != onboardingPages.length - 1,
              child: TextButton(
                onPressed: () {
                  _pageController.jumpToPage(onboardingPages.length - 1);
                },
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFD29062),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Visibility(
              visible: _currentPageIndex == onboardingPages.length - 1,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                    ref
                        .read(onboardingViewModelProvider.notifier)
                        .openLoginView();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(const Color(0xFFD29062)),
                    minimumSize: WidgetStateProperty.all(
                        const Size(double.infinity, 50)),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingPages.length,
                (index) => buildDot(index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      width: 10,
      height: 110,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPageIndex == index ? Colors.black : Colors.grey,
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imageUrl,
            height: 400,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final String imageUrl;

  const OnboardingItem({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

final List<OnboardingItem> onboardingPages = [
  const OnboardingItem(
    title: 'Choose Your Favourite Drink',
    description: 'Find your preferred beverage anytime, anywhere with ease.',
    imageUrl: 'assets/svg/chill.svg',
  ),
  const OnboardingItem(
    title: 'Grab a Drink to Refresh Yourself',
    description:
        'Whether it is a long day after work or game night, we are always here to refresh you.',
    imageUrl: 'assets/svg/ordering.svg',
  ),
  const OnboardingItem(
    title: 'Fastest Delivery Experience Ever',
    description: 'Because Chilled drinks always taste better.',
    imageUrl: 'assets/svg/deliver.svg',
  ),
];
