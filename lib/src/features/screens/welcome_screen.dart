import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wysowl/src/constants/images/images_string.dart';
import 'package:wysowl/src/features/widgets/welcome_screen/login_box.dart';
import 'package:wysowl/src/providers/media_query_provider.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = ref.watch(mediaHeightProvider);
    final width = ref.watch(mediaWidthProvider);

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage2),
            fit: BoxFit.cover,
          )
        ),
    
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: height * 0.08),
            Image.asset(peopleCommunicating,width: height*0.45),
            const LoginBox(),
          ],
        ),
      ),
    );
  }
}