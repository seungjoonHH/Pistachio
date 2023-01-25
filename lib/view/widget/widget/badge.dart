import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/json/badge.dart';
import 'package:pistachio/model/class/database/collection.dart';
import 'package:pistachio/presenter/global.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class CollectionWidget extends StatelessWidget {
  CollectionWidget({
    Key? key,
    this.collection,
    this.detail = false,
    this.selected = false,
    this.pressed = false,
    VoidCallback? onPressed,
    this.onLongPressed,
    this.size = 80.0,
    this.color = PTheme.lightGrey,
    this.border = true,
  }) : onPressed = onPressed ?? (() => GlobalPresenter.showCollectionDialog(collection)),
        super(key: key);

  final Collection? collection;
  final bool detail;
  final bool selected;
  final bool pressed;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final double size;
  final Color color;
  final bool border;

  @override
  Widget build(BuildContext context) {
    PolygonBorder side = PolygonBorder(
      sides: 6,
      side: BorderSide(
        width: (selected ? 4.5 : 1.5).r,
        color: collection == null && border
            ? PTheme.black : Colors.transparent,
      ),
    );

    return Stack(
      children: [
        if (collection != null)
        Image.asset(collection!.badge!.imageUrl!,
          width: (size + 3.0).r, height: (size + 3.0).r,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Material(
                  color: collection == null
                      ? color : Colors.transparent,
                  shape: side,
                  child: InkWell(
                    onTap: onPressed,
                    onLongPress: onLongPressed,
                    customBorder: side,
                    splashColor: PTheme.black.withOpacity(.1),
                    child: SizedBox(
                      width: (size + 3.0).r,
                      height: (size + 3.0).r,
                    ),
                  ),
                ),
                if (selected)
                Container(
                  decoration: const BoxDecoration(
                    color: PTheme.colorB,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check_circle_outline_rounded,
                    size: 40.0.r,
                    color: PTheme.background,
                  ),
                ),
                if (pressed)
                Container(
                  decoration: const BoxDecoration(
                    color: PTheme.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check_circle_outline_rounded,
                    size: 40.0.r,
                    color: PTheme.white,
                  ),
                ),
              ],
            ),
            if (detail)
            Column(
              children: [
                const SizedBox(height: 10.0),
                PText(collection?.badge?.title ?? '',
                  maxLines: 1,
                  align: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                Container(
                  width: 30.0.r,
                  height: 30.0.r,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: PTheme.surface,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: border
                          ? PTheme.black
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: PText(
                    '${collection?.dates.length ?? ''}',
                    border: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}


class BadgeWidget extends StatelessWidget {
  BadgeWidget({
    Key? key,
    this.badge,
    this.detail = false,
    VoidCallback? onPressed,
    this.size = 80.0,
    this.color = PTheme.lightGrey,
    this.border,
    this.completed = false,
    this.received = false,
    this.greyscale = false,
    this.lock = false,
  }) : onPressed = onPressed ?? (() => GlobalPresenter.showBadgeDialog(badge)),
        super(key: key);

  final PBadge? badge;
  final bool detail;
  final VoidCallback? onPressed;
  final double size;
  final Color color;
  final bool? border;
  final bool completed;
  final bool received;
  final bool greyscale;
  final bool lock;

  @override
  Widget build(BuildContext context) {
    const List<double> matrix = [
      .2126, .7152, .0722, .0, .0,
      .2126, .7152, .0722, .0, .0,
      .2126, .7152, .0722, .0, .0,
      .0, .0, .0, .5, .0,
    ];

    PolygonBorder side = PolygonBorder(
      sides: 6,
      side: BorderSide(
        width: 1.5.r,
        color: border == null
            ? (badge == null ? PTheme.black : Colors.transparent)
            : Colors.transparent,
      ),
    );

    return Column(
      mainAxisAlignment: detail
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            if (badge != null)
            Stack(
              alignment: Alignment.center,
              children: [
                if (completed && !received)
                Image.asset(badge!.imageUrl!,
                  width: (size + 3.0).r,
                  height: (size + 3.0).r,
                ).animate(
                  onPlay: (cont) => cont.repeat(reverse: true),
                ).fade(end: .8).scale(
                  duration: const Duration(milliseconds: 500),
                  end: const Offset(.95, .95),
                ) else Stack(
                  alignment: Alignment.center,
                  children: [
                    ColorFiltered(
                      colorFilter: greyscale
                          ? const ColorFilter.matrix(matrix)
                          : const ColorFilter.mode(
                        Colors.transparent,
                        BlendMode.saturation,
                      ),
                      child: Image.asset(badge!.imageUrl!,
                        width: (size + 3.0).r,
                        height: (size + 3.0).r,
                      ),
                    ),
                    if (lock)
                    Icon(
                      Icons.lock,
                      size: 40.0.r,
                      color: PTheme.black,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  color: badge == null
                      ? color : Colors.transparent,
                  shape: side,
                  child: InkWell(
                    onTap: greyscale ? () {} : onPressed,
                    customBorder: side,
                    splashColor: PTheme.black.withOpacity(.1),
                    child: Container(
                      width: size.r,
                      height: size.r,
                      decoration: ShapeDecoration(
                        color: onPressed != null
                            ? Colors.transparent : null,
                        shape: side,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (completed)
            Material(
              color: PTheme.white.withOpacity(received ? .7 : .0),
              shape: side,
              child: InkWell(
                onTap: onPressed,
                customBorder: side,
                splashColor: PTheme.black.withOpacity(.1),
                child: Container(
                  width: size.r,
                  height: size.r,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(shape: side),
                  child: Stack(
                    children: [
                      if (received)
                      RotationTransition(
                        turns: const AlwaysStoppedAnimation(-.075),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: PTheme.colorB, width: 2.0),
                          ),
                          child: PText(' 완 료 ',
                            style: textTheme.headlineMedium,
                            color: PTheme.colorB,
                          ),
                        ),
                      ) else Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                        decoration: BoxDecoration(
                          color: PTheme.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: const [BoxShadow(color: PTheme.grey, blurRadius: 20.0)],
                        ),
                        child: PText('수령하기', style: textTheme.titleMedium, color: PTheme.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        if (detail)
        Column(
          children: [
            const SizedBox(height: 10.0),
            PText(badge?.title ?? '',
              maxLines: 1,
              align: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            SizedBox(height: 30.0.r),
          ],
        ),
      ],
    );
  }
}
