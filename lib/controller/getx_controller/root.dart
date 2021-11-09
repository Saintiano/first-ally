
import 'package:firstallytestappplication/components/bottom_nav_bar.dart';
import 'package:firstallytestappplication/views/login.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../firebase_controller.dart';

class Root extends GetWidget<Firebase_Controller> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx((){
      return (Get.find<Firebase_Controller>().user != null) ? const Bottom_Nav_Bar() : const Login();
    });
    throw UnimplementedError();
  }

}