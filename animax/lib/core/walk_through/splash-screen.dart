import 'package:animax/utils/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/services/SharedPrefService.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 3000), () async {
      String? token=await getToken();
      if(token!=null) {
        var response=await validateToken(token);
        debugPrint('$response');
        if(response.statusCode == 200){
          Get.offAllNamed("/dashboard");
        }else{
          Get.offAllNamed('/login');
        }
      }else{
        Get.offNamed('/walk');
      }
    });
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.animation_rounded,
              color: Theme.of(context).primaryColor,
              size: 200,
            ),
            const SizedBox(
              height: 90,
            ),
            Icon(
              Icons.local_fire_department_sharp,
              color: Theme.of(context).primaryColor,
              size: 60,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Loading",
              style: TextStyle(color: Theme.of(context).primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
