import 'package:flutter/material.dart';

class TopTitle extends StatelessWidget {
  final String title, subtitle;
  const TopTitle({Key? key, required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kToolbarHeight + 12,),
        Row(
          children: [
            if(title == "Login" || title == "Create Account") const BackButton(),
            const SizedBox(width: 12,),
            Text(title, style: const TextStyle(fontSize: 18, fontFamily: 'Roboto', fontWeight: FontWeight.w700),),
          ],
        ),
        const SizedBox(height: 12,),
        Text(subtitle, style: const TextStyle(fontSize: 18, fontFamily: 'Roboto', fontWeight: FontWeight.w400),),
      ],
    );
  }
}
