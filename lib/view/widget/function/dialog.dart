import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class DialogButtonData {
  late DialogType type;
  Color color;
  String text;
  BorderRadius radius;
  VoidCallback onPressed;

  DialogButtonData(type, {
    Color? color,
    required this.text,
    required this.radius,
    required this.onPressed,
  }) : color = color ?? PTheme.black;
}

void showPDialog({
  required String title,
  required Widget content,
  DialogType type = DialogType.none,
  String? buttonText,
  VoidCallback? onPressed,
  String? leftText,
  String? rightText,
  VoidCallback? leftPressed,
  VoidCallback? rightPressed,
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
        leftText == null && leftPressed == null
          && rightText == null && rightPressed == null
      )); break;
  }

  switch (type) {
    case DialogType.none: break;
    case DialogType.mono:
      data = [
        DialogButtonData(type,
          text: buttonText ?? '확인',
          color: colorScheme.primaryContainer,
          radius: const BorderRadius.vertical(
            bottom: Radius.circular(20.0),
          ),
          onPressed: onPressed!,
        ),
      ]; break;
    case DialogType.bi:
      data = [
        DialogButtonData(type,
          text: leftText ?? '취소',
          color: colorScheme.primaryContainer.withOpacity(.3),
          radius: const BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
          ),
          onPressed: leftPressed!,
        ),
        DialogButtonData(type,
          text: rightText ?? '확인',
          color: colorScheme.primaryContainer,
          radius: const BorderRadius.only(
            bottomRight: Radius.circular(20.0),
          ),
          onPressed: rightPressed!,
        ),
      ]; break;
  }

  assert(type.index == data.length);

  Get.dialog(
    AlertDialog(
      title: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0, vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: type == DialogType.none
              ? colorScheme.primaryContainer
              : Colors.transparent,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        child: Center(
          child: PText(title,
            style: textTheme.labelLarge,
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
            padding: const EdgeInsets.all(20.0),
            constraints: const BoxConstraints(minHeight: 80.0),
            child: content,
          ),
          Row(
            children: data.map((datum) => Expanded(
              child: Material(
                color: datum.color,
                borderRadius: datum.radius,
                child: InkWell(
                  onTap: datum.onPressed,
                  borderRadius: datum.radius,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: PText(datum.text),
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