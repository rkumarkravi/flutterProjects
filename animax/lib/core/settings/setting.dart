import 'package:animax/utils/services/SharedPrefService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SettingsList(
          sections: [
            SettingsSection(
              title: const Text('Account'),
              tiles: <SettingsTile>[
                SettingsTile(
                  onPressed: (context) {
                    removeToken();
                    Get.offAllNamed("/login");
                  },
                  leading: const Icon(Icons.exit_to_app_sharp),
                  title: const Text('Sign Out'),
                ),
              ],
            ),
          ],
        ),
      );
  }
}
