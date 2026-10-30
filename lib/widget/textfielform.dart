import 'package:flutter/material.dart';

class CustomTextfielform extends StatelessWidget {
  const CustomTextfielform(
    this.controller, {
    super.key,
    required this.hinText,
    this.prefixicon,
    required this.obusreText,
    this.onsuffixPressed,
    this.validator,
    this.labeltext,
  });

  final String hinText;
  final IconData? prefixicon;
  final bool obusreText;
  final String? labeltext;
  // Function សម្រាប់ចុចភ្នែក
  final VoidCallback? onsuffixPressed;
  final TextEditingController? controller;
  // Function សម្រាប់ validation
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // Password បិទ/បើក
      obscureText: obusreText,
      // Validation
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hinText,
        labelText: labeltext,

        // Background
        fillColor: Colors.white10,
        filled: true,
        // Icon ខាងឆ្វេង
        prefixIcon: Icon(prefixicon),

        // Icon ភ្នែក 👁️
        suffixIcon: onsuffixPressed != null
            ? IconButton(
                onPressed: onsuffixPressed,
                icon: Icon(
                  obusreText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              )
            : null,

        hintStyle: TextStyle(color: Colors.black87, fontSize: 12),

        // Default border
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),

        // Border ពេលមិនចុច
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black87, width: 1),
        ),

        // Border ពេលចុច Input
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green, width: 1),
        ),

        // Border ពេល Error
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),

        // Border ពេល Error + ចុច
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );
  }
}
