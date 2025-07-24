import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/route/navigator.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';
import 'package:pantrikita/core/util/validator/validator.dart';
import 'package:pantrikita/core/widgets/bottom_navigation.dart';
import 'package:pantrikita/core/widgets/button.dart';
import 'package:pantrikita/core/widgets/custom_textformfield.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> keyformLogin = GlobalKey<FormState>();
  final TextEditingController ctrEmail = TextEditingController();
  final TextEditingController ctrPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorValue.backgroundColor,
      body: SafeArea(
        child: Container(
          width: screenWidth,
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Form(
            key: keyformLogin,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Text(
                        "Login",
                        style: tsHeadingLargeBold(ColorValue.black),
                      ),
                      Text(
                        "Fill your email and password to continue!",
                        style: tsBodySmallMedium(ColorValue.grayDark),
                      ),

                      const SizedBox(height: 120),

                      Text(
                        "Email",
                        style: tsBodyMediumMedium(ColorValue.grayDark),
                      ),

                      const SizedBox(height: 10),
                      CustomTextFormField(
                        label: "example@gmail.com",
                        controller: ctrEmail,
                        textInputType: TextInputType.text,
                        validator: (value) => Validator.emailValidator(value),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Password",
                        style: tsBodyMediumMedium(ColorValue.grayDark),
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        label: "Enter your password",
                        controller: ctrPassword,
                        textInputType: TextInputType.text,
                        validator: (value) => Validator.emptyValidator(
                          value: value,
                          message: "Password harus di isi",
                        ),
                        isPassword: true,
                      ),

                      const SizedBox(height: 40),
                      BlocConsumer<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state is LoginSuccess) {
                            navigatorPushAndRemove(context, BottomNavigation());

                          } else if (state is LoginFailure) {
                            // showTopSnackBar(
                            //   Overlay.of(context),
                            //   CustomSnackBar.error(message: state.message),
                            // );
                          }
                        },
                        builder: (context, state) {
                          return MyButton(
                            widget: state is LoginLoading
                                ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                                : Text(
                              "Login",
                              style: tsBodyMediumMedium(
                                ColorValue.whiteColor,
                              ),
                            ),
                            onPressed: () {
                              if (keyformLogin.currentState!.validate()) {
                                context.read<LoginBloc>().add(
                                  GetLoginEvent(
                                    email: ctrEmail.text,
                                    password: ctrPassword.text,
                                  ),
                                );
                              }
                            },
                            height: 50,
                            colorbtn: WidgetStateProperty.all<Color>(
                              ColorValue.primary,
                            ),
                            width: double.infinity,
                          );
                        },
                      ),

                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have an account?",
                          style: tsBodySmallMedium(ColorValue.grayDark),
                        ),
                        SizedBox(width: 5),
                        InkWell(
                          onTap: () =>
                          {


                            // navigatorReplacement(context, RegisterPage())

                          },
                          child: Text(
                            "Register",
                            style: tsBodySmallMedium(ColorValue.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
