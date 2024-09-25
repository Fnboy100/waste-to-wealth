import 'package:flutter/material.dart';

class IconMenuBarScrollable
    extends StatefulWidget {
  const IconMenuBarScrollable(
      {super.key});
  @override
  IconMenuBarScrollableState createState() =>
      IconMenuBarScrollableState();
}

class IconMenuBarScrollableState
    extends State<IconMenuBarScrollable> {
  final List<Map<String, dynamic>>
      menuItems =
      [
    {
      "icon": Icons.home_outlined,
      "label": "Home"
    },
    {
      "icon": Icons.calendar_today_outlined,
      "label": "Schedule"
    },
    {
      "icon": Icons.emoji_events_outlined,
      "label": "Rewards"
    },
    {
      "icon": Icons.menu_book_outlined,
      "label": "Education"
    },
    {
      "icon": Icons.person_outline,
      "label": "Profile"
    },
  ];

  String
      selectedItem =
      "Home";

  @override
  Widget
      build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF636AE8),
            width: 2.0,
          ),
        ),
      ),
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal, 
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedItem = item["label"];
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    item["icon"],
                    size: 25.0,
                    color: selectedItem == item["label"]
                        ? const Color(0x565E6CFF)
                        :Theme.of(context).colorScheme.onPrimaryFixedVariant,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    item["label"],
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 14/10,
                      fontFamily: 'InterRegular',
                      fontWeight: FontWeight.w600,
                      color: selectedItem == item["label"]
                          ? const Color(0x565E6CFF)
                        :Theme.of(context).colorScheme.onPrimaryFixedVariant ,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
