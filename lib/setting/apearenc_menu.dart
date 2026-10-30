import 'package:flutter/material.dart';
import 'package:flutter_realapp_1/controllers/setting_controller.dart';
import 'package:get/get.dart';

class ApearencMenu extends StatelessWidget {
  ApearencMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final setting = Get.find<SettingController>();

    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Language
                    Text(
                      'language'.tr,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Wrap(
                      children: [
                        TextButton(
                          onPressed: () {
                            setting.changeLanguage('en');
                            Navigator.pop(context);
                          },
                          child: const Text('English'),
                        ),
                        TextButton(
                          onPressed: () {
                            setting.changeLanguage('km');
                            Navigator.pop(context);
                          },
                          child: const Text('ខ្មែរ'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Fonts
                    Text(
                      'fonts'.tr,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Obx(
                      () => Wrap(
                        spacing: 8,
                        children: [
                          for (final font in SettingController.fonts)
                            FilterChip(
                              label: Text(font),

                              selected: setting.fontFamily.value == font,

                              onSelected: (selected) {
                                if (selected) {
                                  setting.fontFamily.value = font;
                                }
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      icon: const Icon(Icons.text_fields_outlined),
    );
  }
}
