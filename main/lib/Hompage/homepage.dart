import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:main/Hompage/build_testimonial_cards.dart';
import 'package:main/Hompage/faq_page.dart';
import 'package:main/Hompage/icon_menubar_scrollable.dart';
import 'package:main/Hompage/image_carousel_with_timer.dart';

class HomePage
    extends StatefulWidget {
  const HomePage(
      {super.key});

  @override
  HomePageState createState() =>
      HomePageState();
}

class HomePageState
    extends State<HomePage> {
  final Location
      _location =
      Location();
  bool
      isLoading =
      true;
  bool
      locationPermissionDenied =
      false;

  final List<String>
      menuList =
      [
    'Schedule Colections',
    'Rewards',
    'Educational Resources'
  ];

  late List<Widget>
      testimonialitems;
  late IconMenuBarScrollable
      iconMenuBarScrollable;

  late ImageCarouselWithTimer
      imageCarouselWithTimer;

  late Widget
      buildFaqpage;

  late String
      selectedFliter;

  @override
  void
      initState() {
    super.initState();
    selectedFliter =
        menuList[0];
    testimonialitems =
        testimonialList();
    buildFaqpage =
        faqPage();
    iconMenuBarScrollable =
        IconMenuBarScrollable(key: widget.key);
    imageCarouselWithTimer =
        ImageCarouselWithTimer(key: widget.key);
    _checkLocationPermissions();
  }

  Future<void>
      _checkLocationPermissions() async {
    bool
        serviceEnabled;
    PermissionStatus
        permissionGranted;

    serviceEnabled =
        await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        _showError('Location services are disabled.');
        setState(() {
          locationPermissionDenied = true;
        });
        return;
      }
    }

    permissionGranted =
        await _location.hasPermission();
    if (permissionGranted ==
        PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        _showError('Location permissions are denied.');
        setState(() {
          locationPermissionDenied = true;
        });
        return;
      }
    }

    _fetchUserLocation();
  }

  Future<void>
      _fetchUserLocation() async {
    try {
      _location.changeSettings(accuracy: LocationAccuracy.high);
      final currentLocation = await _location.getLocation();
      print('Fetched location: ${currentLocation.latitude}, ${currentLocation.longitude}');
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      _showError('Error fetching location: $e');
      setState(() {
        locationPermissionDenied = true;
      });
    }
  }

  void _showError(
      String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget
      build(BuildContext context) {
    if (locationPermissionDenied) {
      return Scaffold(
        body: Center(
          child: Text(
            'Location permission is required to use this app.',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Scaffold(
      body: isLoading ? const Center(child: CircularProgressIndicator()) : _buildHomePageContent(context),
    );
  }

  Widget _selectedLebelTextStyle(
      BuildContext context,
      String label) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF636AE8),
            width: 2.0,
          ),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'InterRegular',
          fontSize: 14.0,
          height: 22 / 14,
          fontWeight: FontWeight.w700,
          color: Color(0xFF636AE8),
        ),
      ),
    );
  }

  Widget
      _buildHomePageContent(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 100.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Home',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Icon(
                  Icons.menu_open_outlined,
                  size: 28.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: SizedBox(
              height: 52.0,
              child: ListView.builder(
                itemCount: menuList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final fliter = menuList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFliter = fliter;
                        });
                      },
                      child: Chip(
                        labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                        elevation: 10.0,
                        side: const BorderSide(style: BorderStyle.none),
                        label: selectedFliter == fliter
                            ? _selectedLebelTextStyle(context, fliter)
                            : Text(
                                fliter,
                                style: const TextStyle(
                                  fontFamily: 'InterRegular',
                                  fontSize: 14.0,
                                  height: 22 / 14,
                                  color: Color(0xFF565E6C),
                                ),
                              ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          imageCarouselWithTimer,
          const SizedBox(height: 24.0),
          Container(
            width: double.infinity,
            height: 230.0,
            color: Colors.white,
            padding: const EdgeInsets.only(top: 20.0, left: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'App Features',
                  style: TextStyle(
                    fontFamily: 'ArchivoBold',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    height: 30 / 20,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 15.0),
                _buildFeatureRow(Icons.calendar_today_outlined, 'Scheldule Waste Collections'),
                const SizedBox(height: 10.0),
                _buildFeatureRow(Icons.emoji_events_outlined, 'Earn Rewards'),
                _buildFeatureRow(Icons.menu_book_outlined, 'Educational Content'),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Testimonials',
                  style: TextStyle(
                    fontFamily: 'ArchivoBold',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    height: 30 / 20,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 15.0),
                Column(
                  children: testimonialitems.map((item) => item).toList(),
                ),
                const SizedBox(height: 15.0),
                buildFaqpage,
                const SizedBox(height: 20.0),
                iconMenuBarScrollable,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(
      IconData icon,
      String title) {
    return Row(
      children: [
        Icon(
          icon,
          weight: 500.0,
          size: 40.0,
          color: const Color.fromARGB(98, 13, 195, 227),
        ),
        const SizedBox(width: 5.0),
        Text(
          title,
          style: const TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}
