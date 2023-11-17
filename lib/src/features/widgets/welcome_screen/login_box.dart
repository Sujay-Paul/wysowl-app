import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:wysowl/src/constants/colors/main_colors.dart';
import 'package:wysowl/src/features/routes/route_names.dart';
import 'package:wysowl/src/providers/language_provider.dart';
import 'package:wysowl/src/providers/media_query_provider.dart';
import 'package:wysowl/src/themes/text_theme.dart';
import 'package:wysowl/src/themes/button_theme.dart';

class LoginBox extends ConsumerWidget {
  const LoginBox({super.key});

  void onLater(BuildContext context){
    // TODO: Anonymous login here
    context.goNamed(RouteNames.home);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = ref.watch(mediaHeightProvider);
    final width = ref.watch(mediaWidthProvider);
    final textData = ref.watch(languageProvider);

    return Container(
      height: height * 0.43,
      width: width * 0.95,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.all(height * 0.025),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                textData['Welcome1']!,
                style: rubikh2,
              ),
              SizedBox(height: height * 0.01),
              Text(
                textData['Welcome2']!,
                textAlign: TextAlign.center,
                style: rubikp1,
                maxLines: 2,
              ),
            ],
          ),
          SizedBox(height: height * 0.001),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.pushNamed(RouteNames.login);
                },
                style: elevatedButtonStyle(padding: height * 0.02),
                child: Text(
                  textData['Welcome3']!,
                  style: rubikb1,
                ),
              ),
              SizedBox(height: height * 0.02),
              ElevatedButton(
                onPressed: () {
                  context.pushNamed(
                    RouteNames.numberVerfication,
                    pathParameters: {'route': 'through SignUp'},
                  );
                },
                style: elevatedButtonStyle(
                    padding: height * 0.02, bgColor: lightestGreyColor),
                child: Text(
                  textData['Welcome4']!,
                  style: rubikb2,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {return onLater(context);},
            child: Text(
              textData['Welcome5']!,
              style: rubikb3,
            ),
          ),
        ],
      ),
    );
  }
}
