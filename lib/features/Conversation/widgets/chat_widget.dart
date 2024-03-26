import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_gpt_task/image_assets.dart';
import 'package:chat_gpt_task/features/Conversation/widgets/text_widget.dart';
import 'package:chat_gpt_task/shared/style/color.dart';
import 'package:chat_gpt_task/shared/style/enum/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardChatList extends StatelessWidget {
  const DashboardChatList({
    super.key,
    required this.msg,
    required this.chatIndex,
    this.shouldAnimate = false,
  });

  final String msg;
  final int chatIndex;
  final bool shouldAnimate;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextWidget(
        maxLine: 1,
        label: msg,
        // textColor: AppMainColors.whiteColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required this.msg,
    required this.chatIndex,
    this.shouldAnimate = false,
  });

  final String msg;
  final int chatIndex;
  final bool shouldAnimate;

  @override
  Widget build(BuildContext context) {
    if (chatIndex == 0) {
      // For User
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(left: 40),
            decoration: ShapeDecoration(
              color: AppMainColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ).r,
              ),
            ),
            child: TextWidget(
              label: msg,
              textColor: AppMainColors.whiteColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    } else {
      // For Bot
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(right: 40),
            decoration: ShapeDecoration(
              color: AppMainColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ).r,
              ),
            ),
            child: shouldAnimate
                ? DefaultTextStyle(
                    style: GoogleFonts.raleway(
                      color: AppMainColors.whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        repeatForever: false,
                        displayFullTextOnTap: true,
                        totalRepeatCount: 1,
                        animatedTexts: [
                          TyperAnimatedText(
                            msg,
                          ),
                        ]),
                  )
                : TextWidget(
                    label: msg,
                    textColor: AppMainColors.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageIcon(
                const AssetImage(Assets.imagesLike),
                color: isDark ? AppMainColors.whiteColor : AppMainColors.darkColor,
              ),
              const SizedBox(
                width: 16,
              ),
              ImageIcon(
                const AssetImage(
                  Assets.imagesDisLike,
                ),
                color: isDark ? AppMainColors.whiteColor : AppMainColors.darkColor,
              ),
              const SizedBox(
                width: 41,
              ),
              ImageIcon(
                const AssetImage(Assets.imagesCopy),
                color: isDark ? AppMainColors.whiteColor : AppMainColors.darkColor,
              ),
              Text(
                'Copy',
                style: Theme.of(context).textTheme.labelSmall,
              )
            ],
          ),
        ],
      );
    }
  }
}
