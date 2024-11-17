import 'package:flutter/material.dart';
import 'package:flutter_body_parts/utils/app_styles.dart';

class SettingsItemCard extends StatelessWidget {
  final String title;
  final String img;
  final Function() onTap;
  const SettingsItemCard(
      {super.key, required this.title, required this.img, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(14)),
        child: ListTile(
          onTap: onTap,
          leading: Image.asset(
            img,
            height: 34,
            width: 34,
          ),
          title: Text(
            title,
            style: AppStyles.textStyle(color: Colors.black, fontSize: 18),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
