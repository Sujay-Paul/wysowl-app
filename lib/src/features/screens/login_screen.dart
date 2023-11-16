import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:wysowl/src/constants/colors/main_colors.dart';
import 'package:wysowl/src/constants/images/images_string.dart';
import 'package:wysowl/src/features/routes/route_names.dart';
import 'package:wysowl/src/providers/language_provider.dart';
import 'package:wysowl/src/providers/media_query_provider.dart';
import 'package:wysowl/src/themes/button_theme.dart';
import 'package:wysowl/src/features/widgets/common_widgets/custom_text_field.dart';
import 'package:wysowl/src/themes/text_theme.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textData = ref.watch(languageProvider);
    final height = ref.watch(mediaHeightProvider);
    final width = ref.watch(mediaWidthProvider);

    String enteredMobileNumber = '';
    String enteredPassword = '';

    void onSave(String? newValue) {
      if (enteredMobileNumber == '') {
        enteredMobileNumber = newValue!;
      } else {
        enteredPassword = newValue!;
      }
    }

    void onLoginWithGoogle() {

      // TODO: Add Google Login Here

    }

    void onLogin() {
      if (formkey.currentState!.validate()) {
        enteredMobileNumber = '';
        enteredPassword = '';
        formkey.currentState!.save();
        int mobileNumber = int.parse(enteredMobileNumber);

        // TODO: Proceed to home page with mobileNumber and enterdPassword 

        context.goNamed(RouteNames.home);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          textData['Login1']!,
          style: rubikh1,
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColorLight2,
      body: Padding(
        padding: EdgeInsets.only(
            right: width * 0.05, left: width * 0.05, bottom: height * 0.3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                onLoginWithGoogle();
              },
              style: elevatedButtonStyle(
                  padding: height * 0.02, bgColor: whiteColor),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    googleLogo,
                    height: height * 0.02,
                  ),
                  SizedBox(width: width * 0.05),
                  Text(
                    textData['Login2']!,
                    style: rubikb4,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Expanded(
                  child: Divider(
                    thickness: 0.5,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.035),
                  child: Text(
                    textData['Login3']!,
                    style: rubikp1,
                  ),
                ),
                const Expanded(
                  child: Divider(
                    thickness: 0.5,
                  ),
                )
              ],
            ),
            Form(
              key: formkey,
              child: Column(
                children: [
                  CustomTextField(
                    veritcalPadding: height * 0.03,
                    fieldHeading: textData['Login4']!,
                    saveData: onSave,
                  ),
                  CustomTextField(
                    veritcalPadding: height * 0.03,
                    fieldHeading: textData['Login8']!,
                    saveData: onSave,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: onLogin,
                  style: elevatedButtonStyle(padding: height * 0.02),
                  child: Text(
                    textData['Login1']!,
                    style: rubikb1,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        context.pushNamed(
                          RouteNames.numberVerfication,
                          pathParameters: {'route': 'through Login'},
                        );
                      },
                      child: Text(
                        textData['Login14']!,
                        style: rubikb2,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
