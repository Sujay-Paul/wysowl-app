import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wysowl/src/constants/texts/english_texts.dart';

class LanguageNotifer extends StateNotifier<Map<String,String>> {
  LanguageNotifer() : super(englishTexts);
  
  void changeLanguage(Map<String,String> texts){
    state = texts;
  }

}

final languageProvider = StateNotifierProvider<LanguageNotifer,Map<String,String>>((ref) => LanguageNotifer());