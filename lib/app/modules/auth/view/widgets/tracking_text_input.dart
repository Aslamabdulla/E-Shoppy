import 'dart:async';

import 'package:e_shoppy/config/theme/dark_theme_colors.dart';
import 'package:e_shoppy/config/theme/light_theme_colors.dart';
import 'package:e_shoppy/utils/input_helper/input_helper.dart';
import 'package:flutter/material.dart';

typedef CaretMoved = void Function(Offset? globalCaretPosition);
typedef TextChanged = void Function(String text);

// Helper widget to track caret position.
class TrackingTextInput extends StatefulWidget {
  const TrackingTextInput(
      {super.key,
      this.onCaretMoved,
      this.onTextChanged,
      this.hint,
      this.label,
      this.isObscured = false,
      this.validator,
      this.onChanged,
      this.icon,
      this.fill});
  final CaretMoved? onCaretMoved;
  final TextChanged? onTextChanged;
  final String? hint;
  final String? label;
  final bool isObscured;
  final String? Function(String?)? validator;
  final IconData? icon;
  final Function(String)? onChanged;
  final Color? fill;
  @override
  TrackingTextInputState createState() => TrackingTextInputState();
}

class TrackingTextInputState extends State<TrackingTextInput> {
  final GlobalKey _fieldKey = GlobalKey();
  final TextEditingController _textController = TextEditingController();
  Timer? _debounceTimer;
  @override
  initState() {
    _textController.addListener(() {
      // We debounce the listener as sometimes the caret position is updated after the listener
      // this assures us we get an accurate caret position.
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 100), () {
        if (_fieldKey.currentContext != null) {
          // Find the render editable in the field.
          final RenderObject? fieldBox =
              _fieldKey.currentContext?.findRenderObject();
          var caretPosition =
              fieldBox is RenderBox ? getCaretPosition(fieldBox) : null;

          widget.onCaretMoved?.call(caretPosition);
        }
      });
      widget.onTextChanged?.call(_textController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          fillColor: widget?.fill,
          filled: widget?.fill != null ? true : false,
          hintText: widget.hint,
          labelText: widget.label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 225, 223, 223),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 235, 234, 234),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 235, 234, 234),
            ),
          ),
          prefixIcon: Icon(
            widget.icon,
            color: DarkThemeColors.primaryColor,
          ),
          errorStyle: const TextStyle(color: Colors.red),
          hintStyle: const TextStyle(
              fontFamily: 'Poppins', color: Colors.black45, fontSize: 13.0),
        ),
        key: _fieldKey,
        controller: _textController,
        obscureText: widget.isObscured,
        validator: widget.validator,
        onChanged: widget.onChanged,
      ),
    );
  }
}
