import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:wysowl/src/constants/colors/main_colors.dart';
import 'package:wysowl/src/features/routes/route_names.dart';
import 'package:wysowl/src/features/widgets/common_widgets/custom_text_field.dart';
import 'package:wysowl/src/providers/language_provider.dart';
import 'package:wysowl/src/providers/media_query_provider.dart';
import 'package:wysowl/src/themes/button_theme.dart';
import 'package:wysowl/src/themes/text_theme.dart';


class MobileVerficationScreen extends ConsumerStatefulWidget {
  const MobileVerficationScreen({
    super.key,
    required this.route,
  });
  
  final String route;

  @override
  ConsumerState<MobileVerficationScreen> createState() => _MobileVerficationScreenState();
}

class _MobileVerficationScreenState extends ConsumerState<MobileVerficationScreen> {
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textData = ref.watch(languageProvider);
    final height = ref.watch(mediaHeightProvider);
    final width = ref.watch(mediaWidthProvider);
    String enteredMobileNumber = '';

    void onSave(String? newValue) {
      enteredMobileNumber = newValue!;
    }

    void onSendOTP() {
      if (formkey.currentState!.validate()) {
        formkey.currentState!.save();

        // TODO: Proceed to send OTP on mobileNumber

        context.pushReplacementNamed(RouteNames.otpVerfication,pathParameters:{'route': widget.route,'number':enteredMobileNumber} );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          textData['MobileVer1']!,
          style: rubikh2,
        ),
        backgroundColor: bgColorLight2,
        centerTitle: true,
      ),
      backgroundColor: bgColorLight2,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          width * 0.06,
          height * 0.02,
          width * 0.06,
          height * 0.06,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  widget.route =='through Login' ? textData['MobileVer2']! : textData['MobileVer4']!,
                  style: rubikp1,
                ),
                SizedBox(height: height * 0.03),
                Form(
                  key: formkey,
                  child: CustomTextField(
                    veritcalPadding: height * 0.025,
                    fieldHeading: textData['Login4']!,
                    saveData: onSave,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: onSendOTP,
              style: elevatedButtonStyle(padding: height * 0.02),
              child: Text(
                textData['MobileVer3']!,
                style: rubikb1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
