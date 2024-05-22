import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "About Us",
          style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.w700),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Text("At ARShop, we're dedicated developers crafting an exciting augmented reality-based shopping experience for furniture enthusiasts like you! Imagine being able to virtually place furniture items in your home before making a purchase, ensuring they fit perfectly with your decor and lifestyle. With our user-friendly app, you can explore a wide range of furniture collections, visualize how they look in your space, and make informed decisions effortlessly. Say goodbye to the guesswork of online furniture shopping and hello to a whole new way of furnishing your home. Join us on this journey to revolutionize the way you shop for furniture, making it simpler, more enjoyable, and tailored just for you. Welcome to ARShop, where your dream home is just a tap away!"),
      ),
    );
  }
}
