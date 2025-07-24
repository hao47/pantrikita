import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/route/navigator.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';
import 'package:pantrikita/core/widgets/button.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../bloc/profile_bloc.dart';

class WidgetProfileContent extends StatelessWidget {
  final ProfileSuccess state;

  const WidgetProfileContent({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final profile = state.profile;
    final bio = profile.data.bio;
    final impact = profile.data.impact;

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
                  style: tsTitleMediumBold(ColorValue.black),
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
                      color: ColorValue.primary,
                    ),
                    child: Center(
                      child: Text(
                        bio.username.isNotEmpty
                            ? bio.username[0].toUpperCase()
                            : 'U',
                        style: const TextStyle(
                          color: ColorValue.whiteColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bio.username, style: tsBodyLargeSemibold(ColorValue.black)),
                      const SizedBox(height: 4),
                      Text(bio.email, style: tsBodySmallRegular(ColorValue.grayDark)),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40),
              Text('Your Impact', style: tsBodyLargeSemibold(ColorValue.black)),
              const SizedBox(height: 20),

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
                          Text('Saved Food', style: tsBodySmallMedium(ColorValue.primary)),
                          const SizedBox(height: 8),
                          Text(impact.foodSave.toString(), style: tsTitleSmallSemibold(ColorValue.primary)),
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
                          Text('Waste Reduced', style: tsBodySmallMedium(ColorValue.primary)),
                          const SizedBox(height: 8),
                          Text(impact.wasteReduced, style: tsTitleSmallSemibold(ColorValue.primary)),
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
                          Text('Items Scanned', style: tsBodySmallMedium(ColorValue.primary)),
                          const SizedBox(height: 8),
                          Text(impact.itemScanned.toString(), style: tsTitleSmallSemibold(ColorValue.primary)),
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
                          Text('Expiring Soon', style: tsBodySmallMedium(ColorValue.primary)),
                          const SizedBox(height: 8),
                          Text(impact.expiringSoon.toString(), style: tsTitleSmallSemibold(ColorValue.primary)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
              Text('Settings', style: tsBodyLargeSemibold(ColorValue.black)),
              const SizedBox(height: 20),

              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: ColorValue.silver,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Icon(Icons.bookmark_outline, color: ColorValue.primary),
                ),
                title: Text('Saved Recipes', style: tsBodySmallMedium(ColorValue.black)),
                trailing: const Icon(Icons.chevron_right, color: ColorValue.gray),
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
                  child: const Icon(Icons.notifications_outlined, color: ColorValue.primary),
                ),
                title: Text('Notification Settings', style: tsBodySmallMedium(ColorValue.black)),
                trailing: const Icon(Icons.chevron_right, color: ColorValue.gray),
                onTap: () {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.info(message: "Notification settings coming soon!"),
                  );
                },
              ),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: ColorValue.silver,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Icon(Icons.edit_outlined, color: ColorValue.primary),
                ),
                title: Text('Edit Profile', style: tsBodySmallMedium(ColorValue.black)),
                trailing: const Icon(Icons.chevron_right, color: ColorValue.gray),
                onTap: () {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.info(message: "Edit profile feature coming soon!"),
                  );
                },
              ),

              const SizedBox(height: 60),
              MyButton(
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.logout, color: ColorValue.red, size: 22),
                    const SizedBox(width: 10),
                    Text('Log Out', style: tsBodyMediumBold(ColorValue.red)),
                  ],
                ),
                onPressed: () {
                  _showLogoutDialog(context);
                },
                colorbtn: WidgetStateProperty.all<Color>(Colors.transparent),
                width: double.infinity,
                isOutlined: true,
                borderColor: ColorValue.red,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }


  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: ColorValue.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Text(
                'Logging Out?',
                style: tsTitleSmallSemibold(ColorValue.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                'Are you sure you want to log out? You\'ll need to login again to access your account.',
                style: tsBodySmallRegular(ColorValue.grayDark),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: MyButton(
                      widget: Text(
                        'No',
                        style: tsBodySmallMedium(ColorValue.grayDark),
                      ),
                      onPressed: () => navigatorPop(dialogContext),
                      colorbtn: WidgetStateProperty.all<Color>(Colors.transparent),
                      width: double.infinity,
                      height: 40,
                      isOutlined: true,
                      borderColor: ColorValue.gray,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: MyButton(
                      widget: Text(
                        'Log out',
                        style: tsBodySmallMedium(ColorValue.whiteColor),
                      ),
                      onPressed: () {
                        navigatorPop(dialogContext);
                        context.read<ProfileBloc>().add(LogoutEvent());
                      },
                      colorbtn: WidgetStateProperty.all<Color>(ColorValue.red),
                      width: double.infinity,
                      height: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
