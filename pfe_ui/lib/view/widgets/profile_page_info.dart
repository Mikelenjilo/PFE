import 'package:flutter/material.dart';

class ProfilePageInfo extends StatelessWidget {
  final IconData icon;
  final String text;
  const ProfilePageInfo({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue.withOpacity(0.2),
                radius: 30.0,
                child: Icon(
                  icon,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 10.0),
              Text(text, style: const TextStyle(fontSize: 15.0)),
            ],
          ),
        ),
      ),
    );
  }
}
