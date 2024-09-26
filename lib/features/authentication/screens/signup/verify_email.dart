
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_tdress/features/authentication/screens/login/login_teacher.dart';
import 'package:quran_tdress/utils/constants/images_strings.dart';
import 'package:quran_tdress/utils/constants/sizes.dart';
import 'package:quran_tdress/utils/constants/text_strings.dart';
import 'package:quran_tdress/utils/helpers/helper_functions.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.offAll(() => const LoginScreen()),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body:  SingleChildScrollView(
        child:  Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            
            children: [
              ///image
              Image(image: AssetImage(TImages.deliveredEmailIllustration ),width: THelperFunctions.screenWidth() * 0.6,),
              const SizedBox(height: TSizes.spaceBtwSections),
              //title and subtitle
              Text(TTexts.confirmEmail ,style:  Theme.of(context).textTheme.headlineMedium , textAlign: TextAlign.center,),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text("esmael12kg@gmail.com" ,style:  Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center,),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(TTexts.confirmEmailSubTitle ,style:  Theme.of(context).textTheme.labelMedium , textAlign: TextAlign.center,),
              const SizedBox(height: TSizes.spaceBtwSections),
              //Buttons
              // SizedBox(width: double.infinity,child: ElevatedButton(onPressed: () => Get.to(()=> SucessScreen(
              //   image: TImages.staticSuccessIllustration,
              //   title: TTexts.yourAccountCreatedTitle,
              //   subtitle: TTexts.yourAccountCreatedSubTitle,
              //   onPressed: () => Get.to(() => const LoginScreen()),
              // )), child: const Text(TTexts.tContinue))),
              const SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(width: double.infinity,child: TextButton(onPressed: (){}, child: Text(TTexts.resendEmail)))
              
              ],
          ),
        ),
      ),
    );
  }
}
