
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quran_tdress/features/authentication/screens/classes/classes_screen.dart';

class NavigationMenuStudent extends StatelessWidget {
  const NavigationMenuStudent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      //Obx() the task what it do is that like a statful widget it allows to the data changes without require statful

      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          //ondestination means which page index user switched
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
        
          destinations: const [
          NavigationDestination(icon: Icon(Iconsax.activity), label: 'active'),
          NavigationDestination(icon: Icon(Iconsax.personalcard), label: 'Course'),
          NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
          NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
        ],
            ),
      ),
    body: Obx(() => controller.screens[controller.selectedIndex.value]),




    );
  }
}


class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;


final screens = [const ClassesScreen(),  Container(), Container(),Container(),];


}