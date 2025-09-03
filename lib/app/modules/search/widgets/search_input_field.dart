import 'package:flutter/material.dart';
import 'package:haly/app/theme/theme/app_theme.dart';

class SearchInputField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final FocusNode focusNode;

  const SearchInputField(
      {super.key, required this.onChanged, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 215, 215, 215),
            width: 1.25,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          focusNode: focusNode,
          onChanged: onChanged,
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 16),
          decoration: const InputDecoration(
            isDense: true,
            hintText:
                'Gözleg (halynyň adyny, reňkini we koduny gözledip bilersiňiz)',
            hintStyle: TextStyle(
              color: Color.fromARGB(255, 102, 102, 102),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: Fonts.gilroyRegular,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 14),
            prefixIcon:
                Icon(Icons.search, color: Color.fromARGB(255, 102, 102, 102)),
          ),
        ),
      ),
    );
  }
}
