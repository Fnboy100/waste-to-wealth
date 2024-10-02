import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'
    as http;
import 'package:location/location.dart';
import 'package:main/Dashboard/nearby_center_widget.dart';
import 'package:main/config/storeage/api_key_type.dart';
import 'package:main/config/storeage/secure_storage_service.dart';
import 'package:main/globalclass/location_app_initializer.dart';

class DashboardPage
    extends StatefulWidget {
  const DashboardPage(
      {super.key});
  @override
  DashboardPageState createState() =>
      DashboardPageState();
}

class DashboardPageState
    extends State<DashboardPage> {
  late String?
      wastemanagementApiKey;
  late String?
      googlAapiKey;

  late LocationAppInitializer
      locationAppInitializer;

  late Future<LocationData?>
      _location;

  List
      articles =
      [];

  @override
  void
      initState() {
    super.initState();
    locationAppInitializer =
        LocationAppInitializer();
    _location =
        compute(fetchLocationInBackground, locationAppInitializer);
  }

  Future<List<dynamic>>
      fetchNews() async {
    final wasteManagementApiKey =
        await SecureStorageService.retrieveApiKey(ApiKeyType.wasteManagementKey);
    const query =
        'waste management';
    final url =
        'https://newsapi.org/v2/everything?q=$query&pageSize=50&apiKey=$wasteManagementApiKey';
    
    final response =
        await http.get(Uri.parse(url));

    if (response.statusCode ==
        200) {
      articles = json.decode(response.body)['articles'];
      return articles;
    } else {
      return throw Exception('Failed to load news');
    }
  }

  Future<LocationData?>
      fetchLocationInBackground(LocationAppInitializer locationAppInitializer) async {
    return await locationAppInitializer.fetchUserLocation();
  }

  @override
  Widget
      build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35.0),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Text(
                  'Dashboard',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.9,
                      clipBehavior: Clip.hardEdge,
                      child: Stack(children: [
                        Positioned(
                          left: 0.0,
                          right: 0.0,
                          top: 0.0,
                          child: Image.asset(
                            'asset/images/waste_image_5.jpg',
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 110.0,
                          right: 110.0,
                          child: Image.asset(
                            'asset/images/logo.png',
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: 550.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 45.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/');
                                },
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(
                                      Icons.home_outlined,
                                      size: 15.0,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 1.0),
                                    Text(
                                      'Home',
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 45.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/reschedule');
                                },
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(
                                      Icons.calendar_today_outlined,
                                      size: 15.0,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 1.0),
                                    Text(
                                      'Schedule',
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 45.0,
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(
                                      Icons.emoji_events_outlined,
                                      size: 15.0,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 1.0),
                                    Text(
                                      'Reward',
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 45.0,
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(
                                      Icons.menu_book_outlined,
                                      size: 15.0,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 1.0),
                                    Text(
                                      'Education',
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Center(
                  child: Text(
                'Nearby Recycling Center',
                style: Theme.of(context).textTheme.headlineMedium,
              )),
              Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: FutureBuilder<LocationData?>(
                    future: _location,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError || snapshot.data == null) {
                        return const Card(
                            elevation: 3.0,
                            margin: EdgeInsets.all(10.0),
                            shadowColor: Colors.blueGrey,
                            child: Center(
                                child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('Failed to retrieve data. Please ensure that permission to access location is granted.'),
                            )));
                      } else {
                        final userLocation = snapshot.data!;
                        print("latitude:${userLocation.altitude}.....logitude:${userLocation.latitude}");
                        return NearbyCenterWidget(
                          latitude: userLocation.latitude!,
                          longitude: userLocation.longitude!,
                        );
                      }
                    },
                  )),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: FutureBuilder<List<dynamic>>(
                        future: fetchNews(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError || snapshot.data == null) {
                            return const Center(child: Text('Failed to fetch news articles.'));
                          } else {
                            final articles = snapshot.data!;
                            return ListView.builder(
                              itemCount: articles.length >= 10 ? 10 : articles.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'New Article',
                                                style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black),
                                              ),
                                              const SizedBox(height: 15.0),
                                              Text(articles[index]['title'] ?? 'Unknown Title'),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Container(
                                          height: MediaQuery.of(context).size.height * 0.1,
                                          width: MediaQuery.of(context).size.width * 0.4,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
                                          clipBehavior: Clip.hardEdge,
                                          child: articles[index]['urlToImage'] != null
                                              ? Image.network(
                                                  articles[index]['urlToImage'],
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  'asset/images/no_Image_Placeholder.png',
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
