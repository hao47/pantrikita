import 'package:flutter/material.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';
import 'package:pantrikita/core/widgets/button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Profile',
                  style: tsTitleSmallBold(ColorValue.black),
                ),
              ),
              const SizedBox(height: 30),

              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorValue.black,
                    ),
                  ),
                  const SizedBox(width: 15),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'grdhck',
                          style: tsBodyLargeSemibold(ColorValue.black)
                      ),
                      SizedBox(height: 4),
                      Text(
                          'kchdrg@gmail.com',
                          style: tsBodySmallRegular(ColorValue.gray)
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40),

              Text(
                  'Your Impact',
                  style: tsBodyLargeSemibold(ColorValue.black)
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ColorValue.primaryTransparant,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              'Saved Food',
                              style: tsBodySmallRegular(ColorValue.black)
                          ),
                          SizedBox(height: 8),
                          Text(
                              '26',
                              style: tsBodyMediumSemibold(ColorValue.black)
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ColorValue.primaryTransparant,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              'Waste Reduced',
                              style: tsBodySmallRegular(ColorValue.black)
                          ),
                          SizedBox(height: 8),
                          Text(
                              '87%',
                              style: tsBodyMediumSemibold(ColorValue.black)
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ColorValue.primaryTransparant,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              'Items Scanned',
                              style: tsBodySmallRegular(ColorValue.black)
                          ),
                          SizedBox(height: 8),
                          Text(
                              '12',
                              style: tsBodyMediumSemibold(ColorValue.black)
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ColorValue.primaryTransparant,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              'Expiring',
                              style: tsBodySmallRegular(ColorValue.black)
                          ),
                          SizedBox(height: 8),
                          Text(
                              '2',
                              style: tsBodyMediumSemibold(ColorValue.black)
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              Text(
                  'Settings',
                  style: tsBodyLargeSemibold(ColorValue.black)
              ),
              const SizedBox(height: 20),

              Column(
                children: [
                  ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: ColorValue.silver,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.bookmark_outline,
                        color: ColorValue.primary,
                      ),
                    ),
                    title: Text(
                        'Saved Recipes',
                        style: tsBodySmallMedium(ColorValue.black)
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: ColorValue.gray,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: ColorValue.silver,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.notifications_outlined,
                        color: ColorValue.primary,
                      ),
                    ),
                    title: Text(
                        'Notification Settings',
                        style: tsBodySmallMedium(ColorValue.black)
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: ColorValue.gray,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: ColorValue.silver,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.edit_outlined,
                        color: ColorValue.primary,
                      ),
                    ),
                    title: Text(
                        'Edit Profile',
                        style: tsBodySmallMedium(ColorValue.black)
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: ColorValue.gray,
                    ),
                    onTap: () {},
                  ),
                ],
              ),

              SizedBox(height: 80),

              MyButton(
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.logout,
                      color: ColorValue.red,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Log Out',
                      style: tsBodyMediumBold(ColorValue.red),
                    ),
                  ],
                ),
                onPressed: () {},
                colorbtn: WidgetStateProperty.all<Color>(Colors.transparent),
                width: double.infinity,
                isOutlined: true,
                borderColor: ColorValue.red,
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}