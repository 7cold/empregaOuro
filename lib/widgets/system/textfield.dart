import 'package:empregaOuro/const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldUi extends StatelessWidget {
  final IconData icon;
  final Widget sufixIcon;
  final String label;
  final bool passTrue;
  final bool readOnly;
  final TextEditingController controller;
  final Function onChanged;
  final Function onTap;
  final Function onSubmitted;
  final TextCapitalization textCapitalization;
  final TextInputType inputType;
  final num maxLines;

  TextFieldUi(
      {@required this.icon,
      @required this.label,
      @required this.passTrue,
      this.controller,
      this.onChanged,
      @required this.textCapitalization,
      this.inputType,
      this.readOnly = false,
      this.onTap,
      this.maxLines = 1,
      this.sufixIcon,
      this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      onTap: onTap,
      readOnly: readOnly,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      controller: controller,
      cursorColor: Color(corSecundaria2),
      cursorWidth: 1.5,
      keyboardType: inputType,
      textCapitalization: textCapitalization,
      obscureText: passTrue,
      style: TextStyle(fontFamily: "FontSemiBold"),
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        suffixIcon: sufixIcon,
        filled: true,
        hintText: label,
        hintStyle: TextStyle(fontFamily: "FontSemiBold"),
        fillColor: CupertinoColors.secondarySystemFill,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent, width: 00),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
      ),
      // validator: validator,
      // onSaved: (value) => controller.text = value,
    );
  }
}
