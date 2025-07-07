import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 40,
            color: const Color.fromARGB(255, 233, 233, 235),
          ),
          Row(
            children: const [
              Icon(Icons.message_outlined, color: Colors.white),
              SizedBox(width: 18),

              SizedBox(width: 20),
              CircleAvatar(
                radius: 14,
                backgroundColor: Color.fromARGB(255, 237, 237, 240),
                child: Icon(
                  Icons.emoji_emotions,
                  color: Color.fromARGB(255, 47, 38, 129),
                  size: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
