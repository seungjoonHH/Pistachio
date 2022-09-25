import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class DialogButtonData {
  late DialogType type;
  Color color;
  String text;
  VoidCallback onPressed;

  DialogButtonData(type, {
    Color? color,
    required this.text,
    required this.onPressed,
  }) : color = color ?? PTheme.black;
}

void showPDialog({
  String? title,
  required Widget content,
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
  Color? leftColor,
  Color? rightColor,
}) {
  List<DialogButtonData> data = [];

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
        leftText == null && leftPressed == null && leftColor == null
          && rightText == null && rightPressed == null && rightColor == null
      )); break;
  }

  switch (type) {
    case DialogType.none: break;
    case DialogType.mono:
      data = [
        DialogButtonData(type,
          text: buttonText ?? '확인',
          color: color ?? PTheme.black,
          onPressed: onPressed!,
        ),
      ]; break;
    case DialogType.bi:
      data = [
        DialogButtonData(type,
          text: leftText ?? '취소',
          color: leftColor ?? PTheme.grey,
          onPressed: leftPressed!,
        ),
        DialogButtonData(type,
          text: rightText ?? '확인',
          color: rightColor ?? PTheme.black,
          onPressed: rightPressed!,
        ),
      ]; break;
  }

  assert(type.index == data.length);

  Get.dialog(
    AlertDialog(
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: PTheme.black, width: 1.5),
        borderRadius: BorderRadius.zero,
      ),
      backgroundColor: PTheme.bar,
      title: Container(
        padding: titlePadding,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        child: Center(
          child: PText(title ?? '',
            style: textTheme.headlineSmall,
            bold: true,
          ),
        ),
      ),
      titlePadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: contentPadding,
            constraints: const BoxConstraints(minHeight: 80.0),
            child: content,
          ),
          Row(
            children: data.map((datum) => Expanded(
              child: Material(
                color: datum.color,
                child: InkWell(
                  onTap: datum.onPressed,
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: PTheme.black),
                    ),
                    child: Center(
                      child: PText(datum.text,
                        color: PTheme.white,
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
    ),
  );
}