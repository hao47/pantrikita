import 'package:flutter/material.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorValue.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorValue.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorValue.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notifications',
          style: tsTitleMediumBold(ColorValue.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildNotificationItem(
            icon: Icons.notifications_outlined,
            iconColor: ColorValue.primary,
            title: '3 items went to expired in 3 days',
            description: 'Some of the ingredients in your pantry are nearing their expiration date. Use them immediately so they don\'t go to waste!',
            time: '13 jam lalu',
          ),
          const SizedBox(height: 20),
          _buildNotificationItem(
            icon: Icons.notifications_outlined,
            iconColor: ColorValue.primary,
            title: '3 items have expired. Check Your Pantry',
            description: 'Check out our Recycling Tips to learn how to dispose of or reuse them wisely.',
            time: '13 jam lalu',
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorValue.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ColorValue.grayTransparent,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon container
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: ColorValue.primaryTransparant,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: tsBodyMediumSemibold(ColorValue.black),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: tsBodySmallRegular(ColorValue.grayDark),
                ),
                const SizedBox(height: 12),
                Text(
                  time,
                  style: tsBodySmallRegular(ColorValue.gray),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}