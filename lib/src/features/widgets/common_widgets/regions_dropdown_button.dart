import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wysowl/src/constants/colors/main_colors.dart';
import 'package:wysowl/src/providers/language_provider.dart';
import 'package:wysowl/src/providers/media_query_provider.dart';
import 'package:wysowl/src/themes/text_theme.dart';

const List<String> regions = [
  'Andaman and Nicobar Islands',
  'Andhra Pradesh',
  'Arunachal Pradesh',
  'Assam',
  'Bihar',
  'Chandigarh',
  'Chhattisgarh',
  'Dadra and Nagar Haveli',
  'Daman and Diu',
  'Delhi',
  'Goa',
  'Gujarat',
  'Haryana',
  'Himachal Pradesh',
  'Jharkhand',
  'Karnataka',
  'Kerala',
  'Ladhak',
  'Lakshadweep',
  'Madhya Pradesh',
  'Maharashtra',
  'Manipur',
  'Meghalaya',
  'Mizoram',
  'Nagaland',
  'Odisha',
  'Puducherry',
  'Punjab',
  'Rajasthan',
  'Sikkim',
  'Tamil Nadu',
  'Telangana',
  'Tripura',
  'Uttar Pradesh',
  'Uttarakhand',
  'West Bengal',
];

class RegionsDropDownButton extends ConsumerStatefulWidget {
  const RegionsDropDownButton({super.key, required this.onChangeFunction});

  final Function(String) onChangeFunction;

  @override
  ConsumerState<RegionsDropDownButton> createState() =>
      _RegionsDropDownButtonState();
}

class _RegionsDropDownButtonState extends ConsumerState<RegionsDropDownButton> {
  String? _selectedRegion;
  @override
  Widget build(BuildContext context) {
    final textData = ref.watch(languageProvider);
    final height = ref.watch(mediaHeightProvider);
    final width = ref.watch(mediaWidthProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textData['SingUp8']!,
          style: rubikb5,
        ),
        SizedBox(height: height * 0.011),
        Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 0.1),
          ),
          child: DropdownButtonFormField(
            style: rubikb6,
            hint: Text(
              textData['SingUp9']!,
              style: rubikp1,
            ),
            value: _selectedRegion,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.abc,
                color: primaryColor,
              ),
              fillColor: whiteColor,
              contentPadding: EdgeInsets.symmetric(
                  vertical: height * 0.019, horizontal: width * 0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                // borderSide: const BorderSide(color:blackColor,width: 10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: primaryColor, width: 2),
              ),
            ),
            items: [
              for (String region in regions)
                DropdownMenuItem<String>(
                  value: region,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(region),
                  ),
                ),
            ],
            onChanged: (newValue) {
              setState(() {
                _selectedRegion = newValue;
                widget.onChangeFunction(newValue!);
              });
            },
          ),
        ),
      ],
    );
  }
}
