import 'package:flutter/material.dart';

import 'owl_spacer.dart';

// import 'package:owl_component_tests/config/index.dart';
typedef textFieldCallback = void Function();

class OwlTextFormField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final Icon fieldIcon;
  final Widget suffixIcon;
  final Color headerColor;
  final Color textColor;
  final FontWeight fontWeight;
  final Color borderColor;
  final double borderRadius;
  final String? prefix;
  final String? label;
  final String? error;
  final String? helper;
  final TextInputType? inputType;
  final int? minLines;
  final int? maxLines;
  final String? Function(String?)? validator;
  final bool? obscure;
  final String? hintText;
  final textFieldCallback? onChanged;

  const OwlTextFormField(
      {super.key,
      required this.controller,
      required this.fieldIcon,
      required this.textColor,
      required this.borderColor,
      this.title = "",
      this.headerColor = const Color(0xFF5E6E7A),
      this.borderRadius = 8,
      this.suffixIcon = const Icon(null),
      this.fontWeight = FontWeight.normal,
      this.prefix,
      this.label,
      this.error = '',
      this.helper,
      this.inputType,
      this.minLines,
      this.maxLines,
      this.validator,
      this.obscure,
      this.hintText,
      this.onChanged});

  @override
  State<OwlTextFormField> createState() => _OwlTextFormFieldState();
}

class _OwlTextFormFieldState extends State<OwlTextFormField> {
  Color textPrimaryColor = const Color(0xFF364A59);
  Color textSecondaryColor = const Color(0xFF5E6E7A);

  @override
  Widget build(BuildContext context) {
    double defaultPadding = 0;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.title.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        color: widget.headerColor,
                        fontWeight: widget.fontWeight),
                  ),
                )
              : Container(),
          const OwlSpacer(height: 10),
          Padding(
              padding: EdgeInsets.fromLTRB(
                  defaultPadding, 0, defaultPadding, defaultPadding),
              child: TextFormField(
                  controller: widget.controller,
                  style: TextStyle(color: widget.textColor),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius),
                        borderSide: BorderSide(color: widget.borderColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius),
                        borderSide: BorderSide(color: widget.borderColor),
                      ),
                      prefixIcon: widget.fieldIcon,
                      prefixText: widget.prefix,
                      labelText: widget.label,
                      helperText: widget.helper,
                      helperStyle: TextStyle(color: textSecondaryColor),
                      errorText: widget.error!.isEmpty ? null : widget.error,
                      errorMaxLines: 2,
                      suffixIcon: widget.suffixIcon,
                      hintText: widget.hintText),
                  keyboardType: widget.inputType ?? TextInputType.text,
                  maxLines: widget.maxLines ?? null,
                  validator: widget.validator,
                  obscureText: widget.obscure ?? false,
                  onChanged: (value) {
                    widget.onChanged!();
                  }))
        ]);
  }
}

// class OwlTextFormField extends StatelessWidget {
//   final String title;
//   final TextEditingController controller;
//   final Icon fieldIcon;
//   final Widget suffixIcon;
//   final Color headerColor;
//   final Color textColor;
//   final FontWeight fontWeight;
//   final Color borderColor;
//   final double borderRadius;
//   final String? prefix;
//   final String? label;
//   final String? error;
//   final String? helper;
//   final TextInputType? inputType;
//   final int? minLines;
//   final int? maxLines;
//   final String? Function(String?)? validator;
//   final List<TextInputFormatter>? inputFormatters;
//   final bool? obscure;
//   final String? hintText;
//   final Function? onChanged;

//   const OwlTextFormField(
//       {Key? key,
//       required this.title,
//       required this.controller,
//       required this.fieldIcon,
//       required this.textColor,
//       required this.borderColor,
//       this.headerColor = textSecondaryColor,
//       this.borderRadius = 8,
//       this.suffixIcon = const Icon(null),
//       this.fontWeight = FontWeight.normal,
//       this.prefix,
//       this.label,
//       this.error,
//       this.helper,
//       this.inputType,
//       this.minLines,
//       this.maxLines,
//       this.validator,
//       this.inputFormatters,
//       this.obscure,
//       this.hintText,
//       this.onChanged})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double defaultPadding = 0;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: defaultPadding),
//           child: Text(
//             title,
//             style: TextStyle(color: headerColor, fontWeight: fontWeight),
//           ),
//         ),
//         const OwlSpacer(height: 10),
//         Padding(
//           padding: EdgeInsets.fromLTRB(
//               defaultPadding, 0, defaultPadding, defaultPadding),
//           child: TextFormField(
//             controller: controller,
//             style: TextStyle(color: textColor),
//             decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(borderRadius),
//                   borderSide: BorderSide(color: borderColor),
//                 ),
//                 //   labelText: labelText,
//                 prefixIcon: fieldIcon == const Icon(null) ? fieldIcon : null,
//                 prefixText: prefix,
//                 labelText: label,
//                 helperText: helper,
//                 helperStyle: const TextStyle(color: textSecondaryColor),
//                 errorText: error,
//                 suffixIcon: suffixIcon,
//                 hintText: hintText),
//             keyboardType: inputType ?? TextInputType.text,
//             maxLines: maxLines ?? null,
//             validator: validator,
//             inputFormatters: inputFormatters,
//             obscureText: obscure ?? false,
//             onChanged: (value) {
//               print(value);
//               onChanged;
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
