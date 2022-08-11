import 'dart:math';

import 'package:pistachio/presenter/page/exercise/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DraggableCircledButton extends StatefulWidget {
  const DraggableCircledButton({
    Key? key,
    this.size = 114.0,
    this.sideSize = 70.0,
    this.interval = 5.0,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 40.0, vertical: 20.0,
    ),
    required this.text,
    required this.leftText,
    required this.rightText,
    required this.onPressed,
    required this.leftSelected,
    required this.rightSelected,
    required this.color,
    required this.leftColor,
    required this.rightColor,
  }) : super(key: key);

  final double size;
  final double sideSize;
  final double interval;
  final EdgeInsets padding;
  final String text;
  final String leftText;
  final String rightText;
  final VoidCallback onPressed;
  final VoidCallback leftSelected;
  final VoidCallback rightSelected;
  final Color color;
  final Color leftColor;
  final Color rightColor;

  @override
  State<DraggableCircledButton> createState() => _DraggableCircledButtonState();
}

class _DraggableCircledButtonState extends State<DraggableCircledButton> {
  late double x;
  late double screenWidth;
  late String text;
  bool dragging = false;
  double get relX => x - screenWidth * .5;
  double get dist => (screenWidth - widget.padding.horizontal - widget.sideSize) * .5;
  double get scale => 1 - (relX / dist).abs();
  double get feedbackSize => widget.sideSize + (
      widget.size - widget.sideSize - widget.interval
  ) * scale;

  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width;
    x = screenWidth * .5;
    text = widget.text;
    super.didChangeDependencies();
  }

  void onPanStart(DragStartDetails details) => setState(() => dragging = true);
  void onPanUpdate(details) => setState(() {
    x = details.localPosition.dx + (screenWidth - widget.size) * .5;
    if (scale > .3) { text = widget.text; }
    else {
      if (relX > 0) {
        x = screenWidth - (widget.padding.horizontal + widget.sideSize) * .5;
        text = widget.rightText;
      }
      else {
        x = (widget.padding.horizontal + widget.sideSize) * .5;
        text = widget.leftText;
      }
    }
  });
  void onPanEnd(details) => setState(() {
    dragging = false;
    if (relX == -dist) { widget.leftSelected(); }
    else if (relX == dist) { widget.rightSelected(); }
    text = widget.text;
    x = screenWidth * .5;
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: widget.padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: widget.sideSize,
                    height: widget.sideSize,
                    decoration: BoxDecoration(
                      border: Border.all(color: widget.leftColor),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(widget.leftText,
                        style: TextStyle(
                          color: widget.leftColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 3.0),
                  SvgPicture.asset('assets/image/page/timer/left_arrow.svg'),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset('assets/image/page/timer/right_arrow.svg'),
                  const SizedBox(width: 3.0),
                  Container(
                    width: widget.sideSize,
                    height: widget.sideSize,
                    decoration: BoxDecoration(
                      border: Border.all(color: widget.rightColor),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(widget.rightText,
                        style: TextStyle(
                          color: widget.rightColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: widget.color),
          ),
          child: Center(
            child: Text(widget.text,
              style: TextStyle(
                color: widget.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Positioned(
          left: x - (feedbackSize + widget.interval) * .5,
          child: GestureDetector(
            onPanStart: onPanStart,
            onPanUpdate: onPanUpdate,
            onPanEnd: onPanEnd,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: feedbackSize - widget.interval,
                  height: feedbackSize - widget.interval,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.leftColor.withOpacity(-min(relX, 0) / dist),
                  ),
                ),
                Container(
                  width: feedbackSize - widget.interval,
                  height: feedbackSize - widget.interval,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.rightColor.withOpacity(max(relX, 0) / dist),
                  ),
                ),
                CircledButton(
                  text: text,
                  onPressed: widget.onPressed,
                  size: feedbackSize + widget.interval,
                  color: widget.color.withOpacity(1 - relX.abs() / dist),
                  fill: true,
                  interval: widget.interval,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


class CircledButton extends StatelessWidget {
  const CircledButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.color,
    this.size = 114.0,
    this.fill = true,
    this.interval = 5.0,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double size;
  final bool fill;
  final double interval;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExerciseMain>(
      builder: (controller) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                border: Border.all(color: color),
                shape: BoxShape.circle,
              ),
            ),
            Center(
              child: Material(
                color: fill ? color : Colors.transparent,
                borderRadius: BorderRadius.circular(57.0),
                child: InkWell(
                  onTap: onPressed,
                  borderRadius: BorderRadius.circular(57.0),
                  child: Container(
                    width: size - interval,
                    height: size - interval,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Center(
                      child: Text(text,
                        style: TextStyle(
                          color: fill ? Colors.white : color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
