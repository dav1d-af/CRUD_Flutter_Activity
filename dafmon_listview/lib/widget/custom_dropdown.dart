import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String selectedYear;
  final List<String> years;
  final ValueChanged<String?> onChanged;

  const CustomDropdown({
    super.key,
    required this.selectedYear,
    required this.years,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedYear,
      padding: const EdgeInsets.only(right: 16.0),
      icon: const Icon(Icons.arrow_downward),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      onChanged: onChanged,
      isExpanded: true,
      items: years.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(value), // Display text
          ),
        );
      }).toList(),
    );
  }
}
