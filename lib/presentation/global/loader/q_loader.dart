import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotex/internal/utils/infrastructure.dart';

class QLoader extends StatelessWidget {
  const QLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 4.w,
      color: whiteColor,
      valueColor: const AlwaysStoppedAnimation(whiteColor),
    );
  }
}
