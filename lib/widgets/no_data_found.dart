import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.hourglass_empty,
            size: 150,
            color: Color.fromARGB(69, 255, 255, 255),
          ),
          Text(
            'Start adding items clicking on the + button.',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
