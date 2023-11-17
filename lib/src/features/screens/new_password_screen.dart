import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wysowl/src/constants/colors/main_colors.dart';
import 'package:wysowl/src/features/routes/route_configs.dart';
import 'package:wysowl/src/features/routes/route_names.dart';
import 'package:wysowl/src/features/widgets/common_widgets/custom_text_field.dart';
import 'package:wysowl/src/providers/language_provider.dart';
import 'package:wysowl/src/providers/media_query_provider.dart';
import 'package:wysowl/src/themes/button_theme.dart';
import 'package:wysowl/src/themes/text_theme.dart';

class NewPasswordScreen extends ConsumerStatefulWidget {
  const NewPasswordScreen({
    super.key,
    required this.number,
    required this.name,
    required this.age,
    required this.region,
  });

  final String number;
  final String name;
  final String age;
  final String region;

  @override
  ConsumerState<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends ConsumerState<NewPasswordScreen> {
  final _formkey = GlobalKey<FormState>();
  String enteredNewPassword = '';
  String enteredConfirmPassword = '';
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    final textData = ref.watch(languageProvider);
    final height = ref.watch(mediaHeightProvider);
    final width = ref.watch(mediaWidthProvider);

    void onCreateAccount() {
      if (_formkey.currentState!.validate()) {
        enteredNewPassword = '';
        enteredConfirmPassword = '';
        _formkey.currentState!.save();

        if (enteredNewPassword == enteredConfirmPassword) {
          final int mobileNumber = int.parse(widget.number);
          if (widget.age == 'null') {
            // TODO: Reset the password of mobileNumber by enteredNewPassword var in database
          } else {
            final String userName = widget.name;
            final int userAge = int.parse(widget.age);
            final String userRegion = widget.region;
            // TODO: Create new account with mobileNumber, userName, userAge, userRegion and enteredNewPassword in database 
            // TODO: If checkboxValue is true then parent account else children account
          }

          popUntil(context, RouteNames.login);
        } else {
          final snackBar = SnackBar(
            content: Text(
              textData['NewPass8']!,
              style: rubikb1,
            ),
            duration: const Duration(seconds: 2),
          );

          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    }

    void onSave(String? newValue) {
      if (enteredNewPassword == '') {
        enteredNewPassword = newValue!;
      } else {
        enteredConfirmPassword = newValue!;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.age == 'null' ? textData['NewPass1']! : textData['NewPass9']!,
          style: rubikh2,
        ),
        backgroundColor: bgColorLight2,
        centerTitle: true,
      ),
      backgroundColor: bgColorLight2,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          width * 0.05,
          height * 0.02,
          width * 0.05,
          height * 0.07,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Text(
                      widget.age == 'null'
                          ? textData['NewPass2']!
                          : textData['NewPass10']!,
                      style: rubikp1,
                    ),
                    SizedBox(height: height * 0.03),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          CustomTextField(
                            veritcalPadding: height * 0.03,
                            fieldHeading: textData['NewPass3']!,
                            saveData: onSave,
                          ),
                          CustomTextField(
                            veritcalPadding: height * 0.03,
                            fieldHeading: textData['NewPass5']!,
                            saveData: onSave,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (widget.age != 'null' && int.parse(widget.age) > 16)
                  Row(
                    children: [
                      Checkbox(
                        fillColor: MaterialStateProperty.resolveWith((states) {
                          if (!states.contains(MaterialState.selected)) {
                            return Colors.white;
                          }
                          return null;
                        }),
                        value: checkboxValue,
                        onChanged: (newValue) {
                          setState(() {
                            checkboxValue = newValue!;
                          });
                        },
                      ),
                      Text(
                        textData['NewPass11']!,
                        style: rubikb5,
                      ),
                    ],
                  ),
              ],
            ),
            ElevatedButton(
              onPressed: onCreateAccount,
              style: elevatedButtonStyle(padding: height * 0.02),
              child: Text(
                textData['NewPass7']!,
                style: rubikb1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
