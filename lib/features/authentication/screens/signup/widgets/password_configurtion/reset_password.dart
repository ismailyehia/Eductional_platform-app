
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_tdress/utils/constants/images_strings.dart';
import 'package:quran_tdress/utils/constants/text_strings.dart';
import 'package:quran_tdress/utils/helpers/helper_functions.dart';

import '../../../../../../utils/constants/sizes.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () => Get.back(), icon: Icon(CupertinoIcons.clear)),
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    Image(
                        image: AssetImage(TImages.deliveredEmailIllustration),
                        width: THelperFunctions.screenWidth() * 0.6),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    //title and subtitle
                    Text(
                      TTexts.changeYourPasswordTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Text(
                      TTexts.changeYourPasswordSubTitle,
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    //buttons
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {}, child: Text(TTexts.done))),

                    const SizedBox(height: TSizes.spaceBtwSections),

                    SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(TTexts.resendEmail),
                        )),
                  ],
                ))));
  }
}
