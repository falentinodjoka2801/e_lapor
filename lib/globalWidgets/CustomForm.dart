import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:flutter/services.dart';

class CustomForm {
  static Widget textFieldLabel(BuildContext parentContext,
      {@required String label,
      double letterSpacing,
      Color color,
      double fontSize,
      FontWeight fontWeight}) {
    SizeConfig().initSize(parentContext);

    double _letterSpacing = 1.5;
    if (letterSpacing != null) {
      _letterSpacing = letterSpacing;
    }

    Color _color = Color(0XFFF5F7FA);
    if (color != null) {
      _color = color;
    }

    double _fontSize = SizeConfig.horizontalBlock * 3.25;
    if (fontSize != null) {
      _fontSize = fontSize;
    }

    FontWeight _fontWeight = FontWeight.w700;
    if (fontWeight != null) {
      _fontWeight = fontWeight;
    }

    return Text(label.toUpperCase(),
        style: TextStyle(
            letterSpacing: _letterSpacing,
            color: _color,
            fontSize: _fontSize,
            fontWeight: _fontWeight));
  }

  static Widget readOnlyTextField(BuildContext parentContext,
      {@required dynamic value,
      Widget leading,
      double leadingAndHintTextSpacing = 0.0,
      Color borderColor,
      double borderWidth = 1.0,
      Widget trailing,
      bool obsecureText = false}) {
    SizeConfig().initSize(parentContext);

    double _horizontalPadding = SizeConfig.horizontalBlock * 3.75;
    double _verticalPadding = SizeConfig.horizontalBlock * 3.25;

    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: _horizontalPadding, vertical: _verticalPadding),
        decoration: BoxDecoration(
            color: CustomColors.eLaporDisabledForm,
            border: (borderColor != null && borderWidth != null)
                ? Border.all(color: borderColor, width: borderWidth)
                : null,
            borderRadius: BorderRadius.circular(8.0)),
        child: Row(children: [
          (leading != null) ? leading : SizedBox(),
          SizedBox(width: leadingAndHintTextSpacing),
          Expanded(
              child: TextFormField(
                  initialValue: value.toString(),
                  obscureText: obsecureText,
                  decoration: InputDecoration(
                      counterText: '',
                      isCollapsed: false,
                      enabled: false,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none))),
          (trailing != null) ? trailing : SizedBox(),
        ]));
  }

  static Widget textField(BuildContext parentContext,
      {@required String hintText,
      @required TextEditingController controller,
      TextStyle hintStyle,
      Widget leading,
      double leadingAndHintTextSpacing = 0.0,
      TextInputType keyboardType = TextInputType.text,
      bool obsecureText = false,
      Widget trailing,
      Color borderColor,
      double borderWidth = 1.0,
      bool enabled = true,
      int maxLength,
      String counterText = '',
      void Function() onEditingComplete,
      void Function(String value) onChange}) {
    SizeConfig().initSize(parentContext);

    TextStyle _hintStyle =
        TextStyle(fontSize: SizeConfig.horizontalBlock * 4.0);
    if (hintStyle != null) {
      _hintStyle = hintStyle;
    }

    double _horizontalPadding = SizeConfig.horizontalBlock * 3.75;
    double _verticalPadding = SizeConfig.horizontalBlock * 3.25;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: _horizontalPadding, vertical: _verticalPadding),
      decoration: BoxDecoration(
          color: (enabled)
              ? CustomColors.eLaporWhite
              : CustomColors.eLaporDisabledForm,
          border: (borderColor != null && borderWidth != null)
              ? Border.all(color: borderColor, width: borderWidth)
              : null,
          borderRadius: BorderRadius.circular(8.0)),
      child: Row(
        children: [
          (leading != null) ? leading : SizedBox(),
          SizedBox(width: leadingAndHintTextSpacing),
          Expanded(
            child: TextField(
                onChanged: (onChange != null) ? onChange : null,
                onEditingComplete:
                    (onEditingComplete != null) ? onEditingComplete : null,
                maxLength: maxLength,
                maxLengthEnforcement:
                    (maxLength != null) ? MaxLengthEnforcement.enforced : null,
                controller: controller,
                keyboardType: keyboardType,
                obscureText: obsecureText,
                decoration: InputDecoration(
                    counterText: counterText,
                    isCollapsed: false,
                    enabled: enabled,
                    hintText: hintText,
                    hintStyle: _hintStyle,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none)),
          ),
          (trailing != null) ? trailing : SizedBox(),
        ],
      ),
    );
  }

  static Widget selectBox(BuildContext parentContext,
      {@required List<DropdownMenuItem> items,
      @required dynamic value,
      @required void Function(dynamic selectedValue) onChanged,
      @required String defaultOptionText,
      @required dynamic defaultOptionValue,
      TextStyle hintStyle,
      Widget leading,
      double leadingAndHintTextSpacing = 0.0,
      TextInputType keyboardType = TextInputType.text,
      bool obsecureText = false,
      Widget trailing,
      Color borderColor,
      double borderWidth = 1.0,
      bool enabled = true}) {
    SizeConfig().initSize(parentContext);

    double _horizontalPadding = SizeConfig.horizontalBlock * 3.75;
    double _verticalPadding = SizeConfig.horizontalBlock * 3.0;

    TextEditingController _controller =
        TextEditingController(text: value.toString());
    if (!enabled) {
      //khusus untuk selectBox yang disabled, nilai trailing ditimpa
      trailing = Icon(Icons.arrow_drop_down);
    }

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: _horizontalPadding, vertical: _verticalPadding),
      decoration: BoxDecoration(
          color: (enabled)
              ? CustomColors.eLaporWhite
              : CustomColors.eLaporDisabledForm,
          border: (borderColor != null && borderWidth != null)
              ? Border.all(color: borderColor, width: borderWidth)
              : null,
          borderRadius: BorderRadius.circular(8.0)),
      child: Row(
        children: [
          (leading != null) ? leading : SizedBox(),
          SizedBox(width: leadingAndHintTextSpacing),
          Expanded(
            child: (enabled)
                ? DropdownButton(
                    onChanged: (enabled) ? onChanged : (selectedValue) => null,
                    items: <DropdownMenuItem>[
                      DropdownMenuItem(
                          child: Text(defaultOptionText),
                          value: defaultOptionValue),
                      ...items
                    ],
                    isDense: true,
                    isExpanded: true,
                    value: value,
                    underline: SizedBox(),
                  )
                : TextField(
                    controller: _controller,
                    keyboardType: keyboardType,
                    obscureText: obsecureText,
                    decoration: InputDecoration(
                        enabled: enabled,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none)),
          ),
          (trailing != null) ? trailing : SizedBox(),
        ],
      ),
    );
  }
}
