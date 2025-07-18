import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

class SpotDropDown extends StatefulWidget {
  const SpotDropDown({
    super.key,
    this.isFloor = true,
    this.onChanged,
  });
  final bool isFloor;
  final dynamic Function(String?)? onChanged;

  @override
  State<SpotDropDown> createState() => _SpotDropDownState();
}

class _SpotDropDownState extends State<SpotDropDown> {
  List<String> floors = ['1st floor', '2nd floor', '3rd floor'];
  List<String> spotTypes = ['Standard', 'VIP'];
  @override
  Widget build(BuildContext context) {
    return CustomDropdown<String>(
      decoration: CustomDropdownDecoration(
        closedFillColor: Colors.grey[200],
        expandedFillColor: Colors.grey[200],
      ),
      items: widget.isFloor ? floors : spotTypes,
      initialItem: widget.isFloor ? floors[0] : spotTypes[0],
      onChanged: widget.onChanged,
    );
  }
}
