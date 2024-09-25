import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget
    buildTestimonialCard({
  required String
      name,
  required String
      avatarUrl,
  required String
      reviewDate,
  required String
      reviewText,
  required double
      rating,
}) {
  return Card(
    elevation:
        2.0,
    shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    child:
        Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(avatarUrl),
                radius: 24.0,
              ),
              const SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'InterBold',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    reviewDate,
                    style: const TextStyle(
                      fontFamily: 'InterRegular',
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              RatingBarIndicator(
                rating: rating,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                unratedColor: Colors.amber.withAlpha(50),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            reviewText,
            style: const TextStyle(
              fontFamily: 'InterRegular',
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}

List<Widget>
    testimonialList() {
  return [
    buildTestimonialCard(
      name: 'John Doe',
      avatarUrl: 'https://example.com/avatar-john.jpg',
      reviewDate: '1 week ago',
      reviewText: 'Excellent app! Scheduling pickups is a breeze, and I\'ve already earned rewards for recycling.',
      rating: 5,
    ),
    buildTestimonialCard(
      name: 'Anna Smith',
      avatarUrl: 'https://example.com/avatar-anna.jpg',
      reviewDate: '2 days ago',
      reviewText: 'The app makes recycling so easy and rewarding! I’ve learned so much about waste management!',
      rating: 4,
    ),
  ];
}
