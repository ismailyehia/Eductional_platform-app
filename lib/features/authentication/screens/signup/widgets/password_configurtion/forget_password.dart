
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quran_tdress/features/authentication/screens/signup/widgets/password_configurtion/reset_password.dart';
import 'package:quran_tdress/utils/constants/sizes.dart';

import '../../../../../../utils/constants/text_strings.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //Heading
            Text(
              TTexts.forgetPassword,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              TTexts.forgetPasswordTitle,
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwItems * 2),

            //textfield
            TextFormField(
                expands: false,
                decoration: const InputDecoration(
                    labelText: TTexts.email,
                    prefixIcon: Icon(Iconsax.direct_right))),

                  const SizedBox(height: TSizes.spaceBtwSections),

            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.off(() => const ResetPassword()),
                  child: const Text(TTexts.createAccount),
                )),
          ]),
        ),
      ),
    );
  }
}
