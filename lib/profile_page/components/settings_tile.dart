// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final dynamic icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon is IconData ? Icon(icon) : icon,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle),
          if (title == "App color theme")
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: ClipOval(
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey[600]!,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(90),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
