import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import 'package:wysowl/src/constants/colors/main_colors.dart';
import 'package:wysowl/src/features/routes/route_names.dart';
// import 'package:wysowl/src/providers/language_provider.dart';
import 'package:wysowl/src/providers/media_query_provider.dart';
import 'package:wysowl/src/themes/button_theme.dart';
import 'package:wysowl/src/themes/text_theme.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  const OtpVerificationScreen(
      {super.key, required this.route, required this.number});

  final String route;
  final String number;

  //TODO: Provide the OTP number here

  @override
  ConsumerState<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final textData = ref.watch(languageProvider);
    final height = ref.watch(mediaHeightProvider);
    final width = ref.watch(mediaWidthProvider);

    const borderColor = primaryColor;
    const errorColor = Color.fromRGBO(255, 234, 238, 1);
    const fillColor = whiteColor;

    final defaultPinTheme = PinTheme(
      width: width * 0.15,
      height: height * 0.076,
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: blackColor, width: 0.5),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification code'),
        centerTitle: true,
        backgroundColor: bgColorLight2,
      ),
      backgroundColor: bgColorLight2,
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text('We have sent an OTP to your number'),
                const Text('mobile number'),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Form(
                    key: _formkey,
                    child: Pinput(
                      length: 5,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          border: Border.all(color: borderColor, width: 2.1),
                        ),
                      ),
                      errorPinTheme: defaultPinTheme.copyWith(
                        decoration: const BoxDecoration(
                          color: errorColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (widget.route == 'through Login') {
                      context.pushReplacementNamed(
                        RouteNames.newPassword,
                        pathParameters: {
                          'number': widget.number,
                          'name': 'null',
                          'age': 'null',
                          'region': 'null'
                        },
                      );
                    } else {
                      context.pushReplacementNamed(
                        RouteNames.signUp,
                        pathParameters: {'number': widget.number},
                      );
                    }
                  },
                  style: elevatedButtonStyle(padding: height * 0.02),
                  child: Text(
                    'Confirm OTP',
                    style: rubikb1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
