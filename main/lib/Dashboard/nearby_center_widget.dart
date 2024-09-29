import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:main/config/storeage/api_key_type.dart';
import 'package:http/http.dart'
    as http;
import 'package:main/config/storeage/secure_storage_service.dart';

class NearbyCenterWidget
    extends StatefulWidget {
  final double
      latitude;
  final double
      longitude;

  const NearbyCenterWidget(
      {super.key,
      required this.latitude,
      required this.longitude});

  @override
  State<NearbyCenterWidget> createState() =>
      _NearbyCenterWidgetState();
}

class _NearbyCenterWidgetState
    extends State<NearbyCenterWidget> {
  Future<List<dynamic>> fetchNearbyRecyclingCenters(
      double latitude,
      double longitude) async {
    final googleApiKey =
        await SecureStorageService.retrieveApiKey(ApiKeyType.googleApiKey);
    final String
        url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=5000&type=recycling_center&key=$googleApiKey';

    final response =
        await http.get(Uri.parse(url));

    if (response.statusCode ==
        200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load nearby recycling centers');
    }
  }

  @override
  Widget
      build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchNearbyRecyclingCenters(widget.latitude, widget.longitude),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No recycling centers found.'));
        } 
        else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final center = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                      leading: Image.network(
                        center['icon'],
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                      title: Text(center['name']),
                      subtitle: Text('${center['vicinity']} - ${center['opening_hours'] != null && center['opening_hours']['open_now'] ? "Open now" : "Closed now"}'),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
