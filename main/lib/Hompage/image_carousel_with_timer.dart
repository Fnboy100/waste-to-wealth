import 'dart:async';
import 'package:flutter/material.dart';

class ImageCarouselWithTimer
    extends StatefulWidget {
  const ImageCarouselWithTimer({super.key});
  @override
  ImageCarouselWithTimerState createState() =>
      ImageCarouselWithTimerState();
}

class ImageCarouselWithTimerState
    extends State<ImageCarouselWithTimer> {
  final PageController
      _pageController =
      PageController();
  int _currentPage =
      0;
  late Timer
      _timer;

  final List<String>
      images =
      [
    'asset/images/waste_image_1.jpg',
    'asset/images/waste_image_2.jpg',
    'asset/images/waste_image_3.jpg',
    'asset/images/waste_image_4.jpg'
  ];

  @override
  void
      initState() {
    super.initState();
    _timer =
        Timer.periodic(const Duration(seconds: 20), (Timer timer) {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 1500),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void
      dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget
      build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Container(
          width: double.infinity,
          height: 421.0,
          decoration: const BoxDecoration(
            color: Color(0x66171A1F),
            borderRadius: BorderRadius.zero,
          ),
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  );
                },
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Text(
                        'Join the Recycling',
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.black, fontSize: 28.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Text(
                        'Revolution',
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.black, fontSize: 28.0),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    const Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Text(
                        'Empowering Communities Through Sustainable Waste Management',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'InterRegular',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          height: 22 / 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Container(
                      height: 36.0,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: WidgetStateColor.resolveWith((states) {
                            if (states.contains(WidgetState.pressed)) {
                              return const Color(0xFF2C35E0);
                            } else if (states.contains(WidgetState.hovered)) {
                              return const Color(0xFF4850E4);
                            } else if (states.contains(WidgetState.disabled)) {
                              return Colors.grey.withOpacity(0.4);
                            }
                            return const Color(0xFF636AE8);
                          }),
                          foregroundColor: WidgetStateColor.resolveWith((states) {
                            if (states.contains(WidgetState.pressed)) {
                              return Colors.white;
                            } else if (states.contains(WidgetState.hovered)) {
                              return Colors.white;
                            } else if (states.contains(WidgetState.disabled)) {
                              return Colors.white.withOpacity(0.4);
                            }
                            return Colors.white;
                          }),
                        ),
                        child: const Text(
                          'Schedule Now',
                          style: TextStyle(
                            fontFamily: 'InterRegular',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            height: 22 / 14,
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
      ],
    );
  }
}
