import 'package:flutter_riverpod/flutter_riverpod.dart';

double screenHeight =0;
double screenWidth =0;

final mediaHeightProvider = Provider((ref) => screenHeight);
final mediaWidthProvider = Provider((ref) => screenWidth);