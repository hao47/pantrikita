import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/route/navigator.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';
import 'package:pantrikita/core/util/validator/validator.dart';
import 'package:pantrikita/core/widgets/button.dart';
import 'package:pantrikita/core/widgets/custom_textformfield.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../bloc/register_bloc.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final GlobalKey<FormState> keyformRegister = GlobalKey<FormState>();
  final TextEditingController ctrEmail = TextEditingController();
  final TextEditingController ctrUsername = TextEditingController();
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
            key: keyformRegister,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Text(
                        "Register",
                        style: tsHeadingLargeBold(ColorValue.black),
                      ),
                      Text(
                        "Create a new account to continue!",
                        style: tsBodySmallMedium(ColorValue.grayDark),
                      ),

                      const SizedBox(height: 120),

                      Text(
                        "Username",
                        style: tsBodyMediumMedium(ColorValue.grayDark),
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        label: "Enter your username",
                        controller: ctrUsername,
                        textInputType: TextInputType.text,
                        validator: (value) => Validator.emptyValidator(
                          value: value,
                          message: "Username harus di isi",
                        ),
                      ),
                      const SizedBox(height: 20),
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

                      BlocConsumer<RegisterBloc, RegisterState>(
                        listener: (context, state) {
                          if (state is RegisterSuccess) {
                            navigatorPushAndRemoveAll(context, LoginPage());
                          } else if (state is RegisterFailure) {
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.error(message: state.message),
                            );
                          }
                        },
                        builder: (context, state) {
                          return MyButton(
                            widget: state is RegisterLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Register",
                                    style: tsBodyMediumMedium(
                                      ColorValue.whiteColor,
                                    ),
                                  ),
                            onPressed: () {
                              if (keyformRegister.currentState!.validate()) {
                                context.read<RegisterBloc>().add(
                                  GetRegisterEvent(
                                    email: ctrEmail.text,
                                    password: ctrPassword.text,
                                    username: ctrUsername.text,
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
                          "Already have an account?",
                          style: tsBodySmallMedium(ColorValue.grayDark),
                        ),
                        SizedBox(width: 5),
                        InkWell(
                          onTap: () =>
                          {


                            navigatorReplacement(context, LoginPage())

                          },
                          child: Text(
                            "Login",
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
