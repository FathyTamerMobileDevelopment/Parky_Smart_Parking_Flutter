import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

enum Gender { male, female }

const List<String> _gender = [
  'Male',
  'Female',
];

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({super.key, this.gender, this.onChanged});
  final Gender? gender;
  final dynamic Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<String>(
      hintText: 'Select Gender',
      decoration: CustomDropdownDecoration(
        closedBorder: Border.all(color: Colors.black54),
      ),
      items: _gender,
      initialItem: gender == null
          ? null
          : gender == Gender.male
              ? _gender[0]
              : _gender[1],
      onChanged: onChanged,
    );
  }
}
