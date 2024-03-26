import 'package:chat_gpt_task/shared/providers/chats_provider.dart';
import 'package:chat_gpt_task/shared/style/color.dart';
import 'package:chat_gpt_task/shared/style/enum/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyDivider extends StatefulWidget {
  const MyDivider({super.key, this.color, this.horizontal, this.vertical});
  final Color? color;
  final double? horizontal;
  final double? vertical;

  @override
  State<MyDivider> createState() => _MyDividerState();
}

class _MyDividerState extends State<MyDivider> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: widget.horizontal ?? 0),
      width: double.infinity,
      height: 1.h,
      color: isDark ? AppMainColors.whiteColor : AppMainColors.darkColor,
    );
  }
}
