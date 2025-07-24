import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/route/navigator.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/widgets/custom_loading.dart';
import 'package:pantrikita/feature/auth/login/presentation/pages/login_page.dart';
import 'package:pantrikita/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:pantrikita/feature/profile/presentation/widgets/profile_content.dart';
import 'package:pantrikita/feature/profile/presentation/widgets/profile_error.dart';
import 'package:pantrikita/feature/profile/presentation/widgets/profile_logout_loading.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../injection-container.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      create: (_) => sl.get<ProfileBloc>()..add(GetProfileEvent()),
      child: Scaffold(
        backgroundColor: ColorValue.backgroundColor,
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.success(
                  message: "Logged out successfully. See you later!",
                ),
              );
              navigatorPushAndRemove(context, LoginPage());
            } else if (state is LogoutFailure) {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.error(
                  message: state.message,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading) return const CustomLoading();
            if (state is LogoutLoading) return WidgetLogoutLoading();
            if (state is ProfileSuccess) return WidgetProfileContent(state: state);
            if (state is ProfileFailure || state is LogoutFailure) return WidgetProfileError(state: state);

            return const SizedBox();
          },
        ),
      ),
    );
  }
}