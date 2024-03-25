import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Notification route'),
          onPressed: () {},
        ),
      ),
    );
  }
}
