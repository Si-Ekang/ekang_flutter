import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LibraryWidget extends StatelessWidget {
  const LibraryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Library route'),
          onPressed: () {},
        ),
      ),
    );
  }
}
