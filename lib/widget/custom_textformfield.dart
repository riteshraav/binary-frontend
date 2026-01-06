import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const CustomTextInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.onChanged,
  });

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  String? errorText;
  bool isFocused = false;
  final FocusNode _focusNode = FocusNode();

  void _validate(String? value) {
    if (widget.validator != null) {
      setState(() {
        errorText = widget.validator!(value);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: errorText != null
                  ? Colors.red
                  : isFocused
                  ? const Color(0xFF2563EB)
                  : const Color(0xFFD1D5DB),
              width: isFocused ? 2.5 : 1.5,
            ),
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            onChanged: (value) {
              widget.onChanged?.call(value);
              _validate(value);
            },
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF111827),
            ),
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 14,
              ),
              border: InputBorder.none, // remove default borders
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 4),
            child: Text(
              errorText!,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.red,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
      ],
    );
  }
}
