
import 'package:flutter/material.dart';
import 'package:quran_tdress/common/styles/spacing_styles.dart';
import 'widgets/divider_form.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

import 'package:quran_tdress/utils/constants/sizes.dart';
import 'package:quran_tdress/utils/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              //Logo & title & subtitle

              TLoginHeader(dark: dark),

              //Form field

              const TLoinForm(),

              // Divider

              const TFormDivider(),

              const SizedBox(height: TSizes.spaceBtwItems,),

              //Footer

              // const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}



