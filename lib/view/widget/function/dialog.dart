import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/enum/dialog.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class DialogButtonData {
  late DialogType type;
  String text;
  Color textColor;
  Color backgroundColor;
  VoidCallback onPressed;

  DialogButtonData(type, {
    Color? textColor,
    Color? backgroundColor,
    required this.text,
    required this.onPressed,
  }) : textColor = textColor ?? PTheme.white,
        backgroundColor = backgroundColor ?? PTheme.black;
}

void showPDialog({
  String? title,
  required Widget content,
  CrossAxisAlignment contentAlignment = CrossAxisAlignment.center,
  EdgeInsets? titlePadding = const EdgeInsets.only(top: 50.0),
  EdgeInsets? contentPadding = const EdgeInsets.all(20.0),
  DialogType type = DialogType.none,
  String? buttonText,
  VoidCallback? onPressed,
  Color? color,
  String? leftText,
  String? rightText,
  VoidCallback? leftPressed,
  VoidCallback? rightPressed,
  Color? leftTextColor,
  Color? rightTextColor,
  Color? leftBackgroundColor,
  Color? rightBackgroundColor,
}) async {
  switch (type) {
    case DialogType.bi:
      assert(onPressed == null && buttonText == null && (
          leftPressed != null && rightPressed != null
      )); break;
    case DialogType.mono:
      assert(onPressed != null && (
          leftText == null && leftPressed == null
              && rightText == null && rightPressed == null
      )); break;
    case DialogType.none:
      assert(onPressed == null && buttonText == null && (
          leftText == null && leftPressed == null
              && leftTextColor == null && leftBackgroundColor == null
              && rightText == null && rightPressed == null
              && rightTextColor == null && rightBackgroundColor == null
      )); break;
  }

  Get.dialog(PAlertDialog(
    title: title,
    content: content,
    contentAlignment: contentAlignment,
    titlePadding: titlePadding,
    contentPadding: contentPadding,
    type: type,
    buttonText: buttonText,
    onPressed: onPressed,
    color: color,
    leftText: leftText,
    rightText: rightText,
    leftPressed: leftPressed,
    rightPressed: rightPressed,
    leftTextColor: leftTextColor,
    rightTextColor: rightTextColor,
    leftBackgroundColor: leftBackgroundColor,
    rightBackgroundColor: rightBackgroundColor,
  ));
}

class PAlertDialog extends StatefulWidget {
  const PAlertDialog({
    Key? key,
    this.title,
    required this.content,
    this.contentAlignment = CrossAxisAlignment.start,
    this.titlePadding = const EdgeInsets.only(top: 50.0),
    this.contentPadding = const EdgeInsets.all(20.0),
    this.type = DialogType.none,
    this.buttonText,
    this.onPressed,
    this.color,
    this.leftText,
    this.rightText,
    this.leftPressed,
    this.rightPressed,
    this.leftTextColor,
    this.rightTextColor,
    this.leftBackgroundColor,
    this.rightBackgroundColor,
  }) : super(key: key);

  final String? title;
  final Widget content;
  final CrossAxisAlignment contentAlignment;
  final EdgeInsets? titlePadding;
  final EdgeInsets? contentPadding;
  final DialogType type;
  final String? buttonText;
  final VoidCallback? onPressed;
  final Color? color;
  final String? leftText;
  final String? rightText;
  final VoidCallback? leftPressed;
  final VoidCallback? rightPressed;
  final Color? leftTextColor;
  final Color? rightTextColor;
  final Color? leftBackgroundColor;
  final Color? rightBackgroundColor;

  @override
  State<PAlertDialog> createState() => _PAlertDialogState();
}

class _PAlertDialogState extends State<PAlertDialog> {
  @override
  Widget build(BuildContext context) {
    List<DialogButtonData> data = [];

    switch (widget.type) {
      case DialogType.none: break;
      case DialogType.mono:
        data = [
          DialogButtonData(widget.type,
            text: widget.buttonText ?? '확인',
            backgroundColor: widget.color ?? PTheme.black,
            onPressed: widget.onPressed!,
          ),
        ]; break;
      case DialogType.bi:
        data = [
          DialogButtonData(widget.type,
            text: widget.leftText ?? '취소',
            textColor: widget.leftTextColor ?? PTheme.black,
            backgroundColor: widget.leftBackgroundColor ?? PTheme.white,
            onPressed: widget.leftPressed!,
          ),
          DialogButtonData(widget.type,
            text: widget.rightText ?? '확인',
            textColor: widget.rightTextColor ?? PTheme.white,
            backgroundColor: widget.rightBackgroundColor ?? PTheme.black,
            onPressed: widget.rightPressed!,
          ),
        ]; break;
    }

    assert(widget.type.index == data.length);

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: PTheme.black, width: 1.5),
        borderRadius: BorderRadius.zero,
      ),
      backgroundColor: PTheme.bar,
      title: Container(
        padding: widget.titlePadding,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        child: Center(
          child: PText(widget.title ?? '',
            style: textTheme.headlineSmall,
            bold: true,
          ),
        ),
      ),
      titlePadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: widget.contentAlignment,
        children: [
          Container(
            padding: widget.contentPadding,
            constraints: const BoxConstraints(minHeight: 80.0),
            child: widget.content,
          ),
          Row(
            children: data.map((datum) => Expanded(
              child: Material(
                color: datum.backgroundColor,
                child: InkWell(
                  onTap: datum.onPressed,
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: PTheme.black),
                    ),
                    child: Center(
                      child: PText(datum.text,
                        color: datum.textColor,
                        style: textTheme.labelLarge,
                      ),
                    ),
                  ),
                ),
              ),
            )).toList(),
          ),
        ],
      ),
      contentPadding: EdgeInsets.zero,
    );
  }
}
