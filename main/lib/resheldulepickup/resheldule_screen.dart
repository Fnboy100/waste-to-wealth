import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RescheduleAppointmentScreen
    extends StatefulWidget {
  const RescheduleAppointmentScreen(
      {super.key});
  @override
  RescheduleAppointmentScreenState createState() =>
      RescheduleAppointmentScreenState();
}

class RescheduleAppointmentScreenState
    extends State<RescheduleAppointmentScreen> {
  DateTime
      selectedDate =
      DateTime.now();

  List<String>
      selectedWasteTypes =
      [];

  Map<String, bool>
      wasteTypes =
      {
    'Plastic':
        false,
    'Glass':
        false,
    'Paper':
        false,
    'Metal':
        false,
    'Electronics':
        false,
    'Organic Waste':
        false,
    'Textiles':
        false,
    'Batteries':
        false,
    'Furniture':
        false,
    'Construction Waste':
        false,
    'Hazardous Waste':
        false,
    'Medical Waste':
        false,
  };

  List<String>
      getSelectedWasteTypes() {
    return wasteTypes.entries.where((entry) => entry.value == true).map((entry) => entry.key).toList();
  }

  void _showConfirmationDialog(
      BuildContext context) {
    selectedWasteTypes =
        getSelectedWasteTypes();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        String reconfirmedSelectedDate = DateFormat('MMMM dd, yyyy').format(selectedDate);
        return Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.4,
          padding: const EdgeInsets.all(8.0),
          child: AlertDialog(
            title: Center(
              child: Text(
                'Confirm Reschedule',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Selected Date: ',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(child: Text(reconfirmedSelectedDate, style: Theme.of(context).textTheme.bodyMedium!.copyWith())),
                  ],
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected Waste Types:',
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                for (var wasteType in selectedWasteTypes)
                  Text(
                    '- $wasteType',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: WidgetStateColor.resolveWith((states) {
                  if (states.contains(WidgetState.pressed)) {
                    return const Color(0xFF2C35E0);
                  } else if (states.contains(WidgetState.hovered)) {
                    return const Color(0xFF4850E4);
                  } else if (states.contains(WidgetState.disabled)) {
                    return Colors.grey.withOpacity(0.4);
                  }
                  return const Color(0xFF636AE8);
                })),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    '/dashboard'
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Reschedule confirmed!', style: Theme.of(context).textTheme.bodyMedium!.copyWith()), backgroundColor: Colors.white),
                  );
          
                },
                child: Text(
                  'Confirm',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget
      build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reschedule Appointment',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.9,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                DateFormat('MMMM yyyy').format(selectedDate),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 16.0),
            CalendarDatePicker(
              initialDate: selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              onDateChanged: (newDate) {
                setState(() {
                  selectedDate = newDate;
                });
              },
            ),
            const SizedBox(height: 20.0),
            Text(
              'Select Waste Type:',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: wasteTypes.keys.map((String wasteType) {
                  return CheckboxListTile(
                    title: Text(wasteType),
                    value: wasteTypes[wasteType],
                    onChanged: (bool? value) {
                      setState(() {
                        wasteTypes[wasteType] = value!;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue),
                ),
                onPressed: () {
                  selectedWasteTypes = getSelectedWasteTypes();
                  if (selectedWasteTypes.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select at least one waste type.'),
                      ),
                    );
                  } else {
                    _showConfirmationDialog(context);
                  }
                },
                child: Text(
                  'Confirm Reschedule',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
