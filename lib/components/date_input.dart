import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servio/utils/date.dart';

class DateInput extends StatefulWidget {
  final String lable;
  final DateTime? initValue;
  final Function(DateTime) onChange;
  DateInput({required this.lable, this.initValue, required this.onChange});
  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  TextEditingController dateinput = TextEditingController();
  @override
  void initState() {
    dateinput.text = widget.initValue == null ? '' : formatForInputField(widget.initValue!);
    super.initState();
  }

  @override
  build(BuildContext context) {
    dateinput.text = widget.initValue == null ? '' : formatForInputField(widget.initValue!);
    return Container(
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )),
        height: 40,
        width: 160.w,
        child: Center(
            child: TextField(
          controller: dateinput, //editing controller of this TextField
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 5, top: 5, bottom: 8),

            labelText: widget.lable, //label text of field
          ),
          readOnly: true, //set it true, so that user will not able to edit text
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: widget.initValue == null ? DateTime.now() : widget.initValue!,
                firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime.now());

            if (pickedDate != null) {
              String formattedDate = formatForInputField(pickedDate);
              widget.onChange(pickedDate);
              setState(() {
                dateinput.text = formattedDate;
              });
            } else {
              print("Date is not selected");
            }
          },
        )));
  }
}
