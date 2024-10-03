
import 'package:flutter/material.dart';

import '../../authentication/login/widgets/divider_form.dart';

import 'widgets/signup_form.dart';
import 'package:quran_tdress/utils/constants/sizes.dart';
import 'package:quran_tdress/utils/constants/text_strings.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Title
              Text(TTexts.signupTitle,style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(
                height: 15,
              ),

              ///Form
              /////form to use multiple text form fiedls
              TSignupform(),
              const SizedBox(height: 9),
              //Divider
              TFormDivider(),
              const SizedBox(height: TSizes.spaceBtwSections),
              // const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
