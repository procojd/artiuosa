import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class controller extends GetxController{
  var selectedindex = 0.obs;

  void onItemTap(int index) {
    
      selectedindex.value = index;
    
     // Close the drawer
  }
}