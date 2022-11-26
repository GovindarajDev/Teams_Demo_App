import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teams/utils/const.dart';
import 'package:teams/utils/utils.dart';

class AppText extends StatelessWidget {
  final String? data;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  AppText(
      {super.key,
      @required this.data,
      @required this.size,
      this.color,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      data ?? '',
      style: TextStyle(
          fontFamily: appFont,
          fontSize: size,
          color: color ?? Colors.black,
          fontWeight: fontWeight ?? FontWeight.normal),
    );
  }
}

verticalSpacer(space) => SizedBox(height: space);
horizondalSpacer(space) => SizedBox(width: space);

class AppTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final bool? isReadyOnly;
  final TextEditingController? controller;
  final TextInputType? keyboardInputType;
  final List<TextInputFormatter>? formatter;
  final Function()? onTaps;
  final String? Function(String?)? validate;
  final String? Function(String?)? onchange;
  final String? Function(String?)? onField;
  final int? maxLength;
  final FocusNode? myFocus;
  final IconData? icon;
  const AppTextField(
      {super.key,
      this.label,
      this.hint,
      this.isReadyOnly,
      this.controller,
      this.keyboardInputType,
      this.formatter,
      this.onTaps,
      this.validate,
      this.onchange,
      this.maxLength,
      this.myFocus,
      this.onField,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // style: TextStyle(color: Theme.of(context).textTheme.headline3?.color),
      onChanged: onchange ?? (val) {},
      validator: validate ??
          (value) {
            return null;
          },
      onTap: onTaps,
      controller: controller,
      focusNode: myFocus,
      readOnly: isReadyOnly ?? false,
      keyboardType: keyboardInputType ?? TextInputType.text,
      maxLength: maxLength,
      inputFormatters: formatter ?? [],
      onFieldSubmitted: onField,
      decoration: InputDecoration(
        suffixIcon: icon != null ? Icon(icon,color: Theme.of(context).iconTheme.color,) : null,
        labelText: label,
        labelStyle: const TextStyle(color: txtHintColor),
        filled: true,
        fillColor: Theme.of(context).cardColor,
        counter: Container(),
        hintText: hint ?? '',
        hintStyle: TextStyle(
          fontSize: width(context) * 0.04,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.headline2?.color
        ),
        contentPadding: const EdgeInsets.all(16),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(4),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(4),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final String? buttonName;
  final EdgeInsets? margin;
  final Function()? onpress;
  const AppButton(
      {super.key,
      @required this.buttonName,
      this.margin,
      @required this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(0.0),
      child: ElevatedButton(
        onPressed: onpress,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              Theme.of(context).buttonTheme.colorScheme?.background),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          minimumSize: MaterialStateProperty.all(
            Size(width(context), height(context) / 16),
          ),
        ),
        child: AppText(
          data: buttonName,
          size: width(context) * 0.04,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).textTheme.button?.color,
        ),
      ),
    );
  }
}
showSnackBar(msg, context) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(msg)));
}