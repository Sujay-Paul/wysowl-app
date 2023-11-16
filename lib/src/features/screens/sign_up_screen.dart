import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:wysowl/src/constants/colors/main_colors.dart';
import 'package:wysowl/src/features/routes/route_names.dart';
import 'package:wysowl/src/features/widgets/common_widgets/custom_text_field.dart';
import 'package:wysowl/src/features/widgets/common_widgets/regions_dropdown_button.dart';
import 'package:wysowl/src/providers/language_provider.dart';
import 'package:wysowl/src/themes/button_theme.dart';
import 'package:wysowl/src/themes/text_theme.dart';
import '../../providers/media_query_provider.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key, required this.number});

  final String number;

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textData = ref.watch(languageProvider);
    final height = ref.watch(mediaHeightProvider);
    final width = ref.watch(mediaWidthProvider);

    String enteredName = '';
    String enteredAge = '';
    String? selectedRegion;

    void onSignUp() {
      if (_formkey.currentState!.validate()) {
        if (selectedRegion != null) {
          enteredName = '';
          enteredAge = '';
          _formkey.currentState!.save();

          context.pushReplacementNamed(
            RouteNames.newPassword,
            pathParameters: {
              'number': widget.number,
              'name': enteredName.trim(),
              'age': enteredAge,
              'region': selectedRegion!,
            },
          );
        } else {
          final snackBar = SnackBar(
            content: Text(
              textData['SignUp16']!,
              style: rubikb2,
            ),
            duration: const Duration(seconds: 2),
          );

          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    }

    void onSave(String? newValue) {
      if (enteredName == '') {
        enteredName = newValue!;
      } else {
        enteredAge = newValue!;
      }
    }

    void onChangeRegion(String newValue) {
      selectedRegion = newValue;
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          context.goNamed(RouteNames.welcome);
        }),
        title: Text(
          textData['SignUp1']!,
          style: rubikh1,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: bgColorLight2,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          width * 0.05,
          height * 0.035,
          width * 0.05,
          height * 0.07,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: _formkey,
              child: Column(
                children: [
                  CustomTextField(
                    veritcalPadding: height * 0.03,
                    fieldHeading: textData['SignUp2']!,
                    saveData: onSave,
                  ),
                  CustomTextField(
                    veritcalPadding: height * 0.03,
                    fieldHeading: textData['SignUp4']!,
                    saveData: onSave,
                  ),
                  RegionsDropDownButton(onChangeFunction: onChangeRegion)
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onSignUp,
              style: elevatedButtonStyle(padding: height * 0.02),
              child: Text(
                textData['SingUp10']!,
                style: rubikb1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
