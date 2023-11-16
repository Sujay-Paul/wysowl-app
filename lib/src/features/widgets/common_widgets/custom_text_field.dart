import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wysowl/src/constants/colors/main_colors.dart';
import 'package:wysowl/src/providers/language_provider.dart';
import 'package:wysowl/src/themes/text_theme.dart';

class CustomTextField extends ConsumerStatefulWidget {
  const CustomTextField({
    super.key,
    required this.veritcalPadding,
    required this.fieldHeading,
    required this.saveData,
  });

  final double veritcalPadding;
  final String fieldHeading;
  final void Function(String?) saveData;

  @override
  ConsumerState<CustomTextField> createState() {
    return _CustomTextFieldState();
  }
}

class _CustomTextFieldState extends ConsumerState<CustomTextField> {
  Widget? suffixIcon;
  bool isSuffixIconOn = false;
  TextInputType? keyboardType;
  Widget? prefixIcon;
  bool isObscureText = false;
  String fieldSubHeading = '';
  Map<String, String> textData = {};

  // ignore: prefer_typing_uninitialized_variables
  var validatorFunction;

  @override
  void initState() {
    textData = ref.read(languageProvider);

    if (widget.fieldHeading == textData['Login4']) {
      keyboardType = TextInputType.phone;
      fieldSubHeading = textData['Login5']!;
      prefixIcon = const Icon(Icons.phone_rounded);
      validatorFunction = phoneNumberValidator;

    } else if ([textData['Login8'], textData['NewPass3'], textData['NewPass5']]
        .contains(widget.fieldHeading)) {
      isSuffixIconOn = true;
      isObscureText = true;
      fieldSubHeading = subHeading;
      prefixIcon = const Icon(Icons.lock_rounded);
      validatorFunction = passwordValidator;

    } else if (widget.fieldHeading == textData['SignUp2']) {
      keyboardType = TextInputType.name;
      fieldSubHeading = textData['SignUp3']!;
      prefixIcon = const Icon(Icons.person);
      validatorFunction = nameValidator;
    } else if (widget.fieldHeading == textData['SignUp4']) {
      keyboardType =
          const TextInputType.numberWithOptions(signed: false, decimal: false);
      fieldSubHeading = textData['SignUp5']!;
      prefixIcon = const Icon(Icons.calendar_month_rounded);
      validatorFunction = ageValidator;
    }

    super.initState();
  }

  String get subHeading {
    if (widget.fieldHeading == textData['Login8']) {
      return textData['Login9']!;
    } else if (widget.fieldHeading == textData['NewPass3']) {
      return textData['NewPass4']!;
    }
    return textData['NewPass6']!;
  }

  String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return textData['Login6'];
    }

    bool hasTendigits = value.trim().length == 10 ? true : false;
    bool isValid = int.tryParse(value) != null ? true : false;

    if (!hasTendigits || !isValid) {
      return textData['Login7'];
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return textData['Login10'];
    }
    if (value.trim().length < 8) {
      return textData['Login11'];
    }

    RegExp hasAlphabet = RegExp(r'[a-zA-Z]+');
    RegExp hasNumber = RegExp(r'\d+');

    if (!hasAlphabet.hasMatch(value)) {
      return textData['Login12'];
    }
    if (!hasNumber.hasMatch(value)) {
      return textData['Login13'];
    }

    return null;
  }

  String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return textData['SignUp11'];
    }

    RegExp isName = RegExp(
        r'^[ ]*[A-Z]?.?[a-z]*([ ]{1}([A-Z]{1}.?[a-z]*|[a-z]+))*[a-z]{2,}[ ]*$');

    if (!isName.hasMatch(value)) {
      return textData['SignUp12'];
    }

    return null;
  }

  String? ageValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return textData['SignUp13'];
    }

    int? age = int.tryParse(value);
    bool isValid = age != null ? true : false;

    if (!isValid || age > 99) {
      return textData['SignUp14'];
    }

    if (age < 8) {
      return textData['SignUp15'];
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (isSuffixIconOn) {
      suffixIcon = IconButton(
        onPressed: () {
          if (isObscureText) {
            setState(() {
              isObscureText = false;
            });
          } else {
            setState(() {
              isObscureText = true;
            });
          }
        },
        icon: isObscureText
            ? const Icon(Icons.visibility_rounded)
            : const Icon(Icons.visibility_off_rounded),
      );
    }

    return Container(
      padding: EdgeInsets.only(bottom: widget.veritcalPadding * 0.8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.fieldHeading,
            style: rubikb5,
          ),
          SizedBox(height: widget.veritcalPadding * 0.35),
          TextFormField(
            style: rubikb6,
            obscureText: isObscureText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: 1,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(widget.veritcalPadding * 0.6),
              prefixIcon: prefixIcon,
              prefixIconColor: primaryColor,
              suffixIcon: suffixIcon,
              suffixIconColor: darkGreyColor,
              label: Text(
                fieldSubHeading,
                style: rubikp1,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              filled: true,
              fillColor: whiteColor,
            ),
            validator: validatorFunction,
            onSaved: widget.saveData,
          )
        ],
      ),
    );
  }
}
