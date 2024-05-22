import 'package:arshop/constants/colors.dart';
import 'package:augmented_reality_plugin/augmented_reality_plugin.dart';
import 'package:flutter/material.dart';
import '../../custom_bottom_navbar/custom_bottom_bar.dart';

class VirtualARViewScreen extends StatefulWidget {
  final String? clickedItemImageLink;

  VirtualARViewScreen({
    this.clickedItemImageLink,
  });

  @override
  State<VirtualARViewScreen> createState() => _VirtualARViewScreenState();
}

class _VirtualARViewScreenState extends State<VirtualARViewScreen> {
  double imageSize = 200.0;
  final double minImageSize = 100.0;
  final double maxImageSize = 300.0;

  bool showCustomBottomBar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primary,
        title: const Text('Virtual AR View', style: TextStyle( color: Colors.white,fontFamily: 'Roboto', fontWeight: FontWeight.w700),),
      ),
      body: Column(
        children: [
          Expanded(
            child: AugmentedRealityPlugin(widget.clickedItemImageLink!.toString()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.photo_size_select_small),
                Expanded(
                  child: Slider(
                    value: imageSize,
                    min: minImageSize,
                    max: maxImageSize,
                    onChanged: (value) {
                      setState(() {
                        imageSize = value;
                      });
                    },
                  ),
                ),
                const Icon(Icons.photo_size_select_large),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: showCustomBottomBar ? const CustomBottomBar() : null,
    );
  }
}
