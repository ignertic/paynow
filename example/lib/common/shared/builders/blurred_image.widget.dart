import 'package:flutter/material.dart';
import 'dart:ui';

class BlurredImageWidget extends StatelessWidget {
  final Color? color;
  final double? sigmaX;
  final double? sigmaY;
  const BlurredImageWidget({
    Key? key,
    required this.image,
    this.color,
    this.sigmaX,
    this.sigmaY,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(image, fit: BoxFit.cover),
        // AnimatedContainer(
        //   duration: Duration(seconds: 2),
        //   color: Colors.grey[200],
        //   child: FadeInImage.assetNetwork(placeholder: image, image: image),
        // ),

        ClipRRect(
          // Clip it cleanly.
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigmaX ?? 1, sigmaY: sigmaY ?? 1),
            child: Container(
              color: color ?? Colors.white.withOpacity(.3),
              alignment: Alignment.center,
            ),
          ),
        ),
      ],
    );
  }
}
