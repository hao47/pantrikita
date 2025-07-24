import 'package:flutter/material.dart';
import 'package:pantrikita/core/route/navigator.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';
import 'package:pantrikita/core/util/validator/validator.dart';
import 'package:pantrikita/core/widgets/button.dart';
import 'package:pantrikita/core/widgets/custom_textformfield.dart';
import 'package:pantrikita/feature/login/presentation/pages/login_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController ctrEmail = TextEditingController();
  final TextEditingController ctrUsername = TextEditingController();
  final TextEditingController ctrPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorValue.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Form(
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
                        textInputType: TextInputType.datetime,
                        validator: (value) => Validator.emailValidator(
                          value,
                        ),
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
                      MyButton(
                        widget: Text(
                          "Register",
                          style: tsBodyMediumMedium(
                            ColorValue.whiteColor,
                          ),
                        ),
                        onPressed: () {
                          // ! tambahkan fungsi onPressed register ! //
                        },
                        height: 60,
                        colorbtn: WidgetStateProperty.all<Color>(
                          ColorValue.primary,
                        ),
                        width: double.infinity,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              height: 1,
                              color: ColorValue.gray,
                            ),
                          ),
                          const Text('or'),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              height: 1,
                              color: ColorValue.gray,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),
                      MyButton(
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 15,
                          children: [
                            Image.asset('assets/image/google.png'),
                            Text(
                              "Register with Google",
                              style: tsBodyMediumMedium(ColorValue.black),
                            ),
                          ],
                        ),
                        height: 60,

                        onPressed: () {},
                        colorbtn: WidgetStateProperty.all<Color>(
                          ColorValue.whiteColor,
                        ),
                        width: double.infinity,
                      ),

                      const SizedBox(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: tsBodyMediumMedium(ColorValue.grayDark),
                          ),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () => navigatorReplacement(context, LoginPage()),
                            child: Text(
                              "Login",
                              style: tsBodyMediumMedium(ColorValue.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
