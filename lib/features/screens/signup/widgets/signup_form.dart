
import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';
import 'package:quran_tdress/common/custom/custom_button.dart';
import 'package:quran_tdress/utils/constants/sizes.dart';
import 'package:quran_tdress/utils/constants/text_strings.dart';

class TSignupform extends StatefulWidget {
  TSignupform({
    super.key,
  });

  @override
  State<TSignupform> createState() => _TSignupformState();
}

class _TSignupformState extends State<TSignupform> {

  final List<String> countires = [
    'Turkiye',
    'United States',
    "Syria",
    "Jordan",
    "Lebanon",
    "Palestine",
    "Egypt",
    "Saudi Arabia",
    'Canada',
    'United Kingdom',
    'Australia',
    'Germany',
    'France',
    'India'
  ];
   final List<String> phoneCountryCodes = ['US', 'CA', 'GB', 'AU' ,'Tr']; // Sample phone country codes

  String? selectedPhoneCountryCode = 'US'; // Default Country Code

  final TextEditingController phoneNumberController = TextEditingController();

  String? selectedcountry;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name", style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
              // maxLines: 1,

              decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(width: 1)),
            labelText: "Full Name",
            prefixIcon: Icon(Iconsax.user),
            contentPadding: EdgeInsets.symmetric(vertical: 17, horizontal: 12),
          )),

          //userName & email & phone number & password
          const SizedBox(
            height: 16,
          ),




          // Phone Number Field
          
            const SizedBox(height: 16),
            Text("Phone number", style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(width: 1),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                    value: selectedPhoneCountryCode,
                    items: phoneCountryCodes.map((code) {
                      return DropdownMenuItem<String>(
                        value: code,
                        child: Text(code),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPhoneCountryCode = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: phoneNumberController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(width: 1),
                      ),
                      labelText: "+1 (555) 000-0000",
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),





        //email field

          Text("Email", style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
              // maxLines: 1,

              decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(width: 1)),
            labelText: "name@email.com",
            prefixIcon: Icon(Iconsax.direct),
            contentPadding: EdgeInsets.symmetric(vertical: 17, horizontal: 12),
          )),

          const SizedBox(
            height: 16,
          ),


              


               Text("Country", style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              

               decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(width: 1),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              hint: const Text("Select Country"),
              icon: const Icon(Icons.arrow_drop_down),
              value: selectedcountry,

              items: countires.map((country){
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country)
                );
                }).toList(),
              
              
              
              
              onChanged: (value){
                setState(() {
                  selectedcountry = value;
                });
              }
              
              
              ),




          Text("Address", style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(
            height: 8,
          ),

          TextFormField(
              // maxLines: 1,

              decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(width: 1)),

            labelText: "Adress",
            prefixIcon: Icon(Iconsax.location),
            // contentPadding: EdgeInsets.symmetric(vertical: 17 , horizontal: 12),
          )),

          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          Text("Password", style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(
            height: 8,
          ),

          TextFormField(
              decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(width: 1),
            ),
            labelText: "Password",
            prefixIcon: Icon(Iconsax.password_check),
            suffixIcon: Icon(Iconsax.eye_slash),
            // contentPadding: EdgeInsets.symmetric(vertical: 17 , horizontal: 12),
          )),

          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),



            // Logo Upload Section
            const SizedBox(height: 16),
            Text("Logo", style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                // Handle the file picker logic here
              },
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.upload, size: 40, color: Colors.grey),
                      SizedBox(height: 8),
                      Text(
                        "Click to upload or drag and drop",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        "SVG, PNG, JPG or GIF (max. 800x400px)",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),






          ///Terms & Condtions Checkbox
          Row(
            children: [
              SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(value: true, onChanged: (value) {})),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: '${TTexts.iAgreeTo} ',
                    style: Theme.of(context).textTheme.bodySmall),
                TextSpan(
                    text: '${TTexts.privacyPolicy} ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(decoration: TextDecoration.underline)),
                TextSpan(
                    text: ' ${TTexts.and} ',
                    style: Theme.of(context).textTheme.bodySmall),
                TextSpan(
                    text: '${TTexts.termsOfUse}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(decoration: TextDecoration.underline)),
              ]))
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          ///Sign up button
          
          CustomButton(text: "Create  Account",func: (){},color: Colors.purple, ),




          // SizedBox(
          //     width: double.infinity,
          //     child: ElevatedButton(
          //         onPressed: () => Get.to(() => const VerifyEmailScreen()),
          //         child: const Text(TTexts.createAccount))),
        ],
      )),
    );
  }
}



