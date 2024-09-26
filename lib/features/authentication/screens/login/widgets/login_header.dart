

import 'package:flutter/material.dart';
import 'package:quran_tdress/utils/constants/images_strings.dart';
import 'package:quran_tdress/utils/constants/sizes.dart';


class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
            height: 150,
            image: AssetImage(
                dark ? TImages.lightAppLogo : TImages.darkAppLogo)),
        Text(
          "Welcome to Quran app ",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: TSizes.sm,
        ),
        Text(
          "Discover and learn about your religion",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
