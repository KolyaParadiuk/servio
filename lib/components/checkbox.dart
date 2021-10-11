import 'package:flutter/material.dart';
import 'package:servio/constants/app_colors.dart';

class CustomCheckbox extends StatefulWidget {
  final String title;
  final void Function(bool?)? onChanged;
  final bool isChecked;

  CustomCheckbox({
    required this.title,
    required this.onChanged,
    required this.isChecked,
  });
  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return kMain;
    }
    return kMain;
  }

  @override
  build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: widget.isChecked,
          onChanged: widget.onChanged,
        ),
        Text(widget.title),
      ],
    );
  }
}
