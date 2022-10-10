import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/json/badge.dart';
import 'package:pistachio/model/class/database/collection.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class CollectionWidget extends StatelessWidget {
  const CollectionWidget({
    Key? key,
    this.collection,
    this.detail = false,
    this.selected = false,
    this.onPressed,
    this.size = 80.0,
    this.color = PTheme.lightGrey,
  }) : super(key: key);

  final Collection? collection;
  final bool detail;
  final bool selected;
  final VoidCallback? onPressed;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    PolygonBorder side = PolygonBorder(
      sides: 6,
      side: BorderSide(
        width: 1.5,
        color: collection == null
            ? PTheme.black : Colors.transparent,
      ),
    );

    return Stack(
      children: [
        if (collection != null)
        Image.asset(collection!.badge!.imageUrl!,
          width: size.r,
          height: size.r,
        ),
        Column(
          children: [
            Material(
              color: collection == null
                  ? color : Colors.transparent,
              shape: side,
              child: InkWell(
                onTap: onPressed,
                customBorder: side,
                splashColor: PTheme.black.withOpacity(.1),
                child: SizedBox(
                  width: size.w,
                  height: size.w,
                  // decoration: ShapeDecoration(
                  //   color: onPressed != null && !selected
                  //       ? color : null,
                  //   shape: side,
                  // ),
                ),
              ),
            ),
            if (detail)
            Column(
              children: [
                const SizedBox(height: 10.0),
                PText(collection?.badge?.title ?? '',
                  maxLines: 2,
                  align: TextAlign.center,
                ),
                Container(
                  width: 24.0,
                  height: 24.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: PTheme.black, width: 1.5),
                  ),
                  child: PText('${collection?.dates.length}', border: true),
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
  const BadgeWidget({
    Key? key,
    this.badge,
    this.detail = false,
    this.selected = false,
    this.onPressed,
    this.size = 80.0,
    this.border = true,
    this.color = PTheme.lightGrey,
  }) : super(key: key);

  final Badge? badge;
  final bool detail;
  final bool selected;
  final VoidCallback? onPressed;
  final double size;
  final bool border;
  final Color color;

  @override
  Widget build(BuildContext context) {
    PolygonBorder side = PolygonBorder(
      sides: 6,
      side: BorderSide(
        width: 1.5,
        color: onPressed != null && selected
            ? PTheme.colorB : border
            ? PTheme.black : Colors.transparent,
      ),
    );

    return Stack(
      children: [
        if (badge != null)
        Image.asset(badge!.imageUrl!,
          width: size.w,
          height: size.w,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: badge == null
                  ? color : Colors.transparent,
              shape: side,
              child: InkWell(
                onTap: onPressed,
                customBorder: side,
                splashColor: PTheme.black.withOpacity(.1),
                child: Container(
                  width: size.r,
                  height: size.r,
                  decoration: ShapeDecoration(
                    color: onPressed != null && !selected
                        ? Colors.transparent : null,
                    shape: side,
                  ),
                ),
              ),
            ),
            if (detail)
            Column(
              children: [
                const SizedBox(height: 10.0),
                PText(badge?.title ?? '',
                  maxLines: 2,
                  align: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
