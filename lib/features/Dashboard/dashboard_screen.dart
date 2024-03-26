import 'package:chat_gpt_task/image_assets.dart';
import 'package:chat_gpt_task/features/Conversation/conversation_screen.dart';
import 'package:chat_gpt_task/features/Dashboard/widgets/list_of_options.dart';
import 'package:chat_gpt_task/features/OnBoarding/on_boarding_screen.dart';
import 'package:chat_gpt_task/features/Conversation/widgets/chat_widget.dart';
import 'package:chat_gpt_task/shared/components/my_divider.dart';
import 'package:chat_gpt_task/shared/components/navigator.dart';
import 'package:chat_gpt_task/shared/providers/chats_provider.dart';
import 'package:chat_gpt_task/shared/services/api_service.dart';
import 'package:chat_gpt_task/shared/style/color.dart';
import 'package:chat_gpt_task/shared/style/enum/enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(),
      child: Scaffold(
        backgroundColor: isDark ? AppMainColors.darkColor : AppMainColors.whiteColor,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 10,
          backgroundColor: isDark ? AppMainColors.darkColor : AppMainColors.whiteColor,
        ),
        body: Column(
          children: [
            GestureDetector(
              onTap: () {
                navigateTo(context, const ConversationScreen());
              },
              child: Container(
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                height: 52.h,
                width: 335.w,
                decoration: BoxDecoration(
                  color: isDark ? AppMainColors.darkColor : AppMainColors.whiteColor,
                  borderRadius: BorderRadius.circular(1),
                ),
                child: Row(
                  children: [
                    ImageIcon(
                      color: isDark ? AppMainColors.whiteColor : AppMainColors.darkColor,
                      const AssetImage(Assets.imagesMessage),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Text(
                      'New Chat',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: !isDark ? AppMainColors.darkColor : AppMainColors.whiteColor,
                          ),
                    ),
                    const Spacer(),
                    ImageIcon(
                      color: isDark ? AppMainColors.whiteColor : AppMainColors.darkColor,
                      const AssetImage(Assets.imagesArrowForward2),
                    ),
                  ],
                ),
              ),
            ),
            const MyDivider(horizontal: 20),
            if (chatProvider.getChatList.isNotEmpty)
              GestureDetector(
                onTap: () {
                  navigateTo(context, const ConversationScreen());
                },
                child: Container(
                  margin: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                  height: 52.h,
                  width: 335.w,
                  decoration: BoxDecoration(
                    // color: AppMainColors.darkColor,
                    borderRadius: BorderRadius.circular(1),
                  ),
                  child: Row(
                    children: [
                       ImageIcon(
                        color: isDark ? AppMainColors.whiteColor : AppMainColors.darkColor,
                        AssetImage(Assets.imagesMessage),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Expanded(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: chatProvider.getChatList.length,
                            itemBuilder: (context, index) {
                              if (chatProvider.getChatList[index].chatIndex == 0) {
                                return DashboardChatList(
                                  msg: chatProvider.getChatList[index].msg,
                                  chatIndex: chatProvider.getChatList[index].chatIndex,
                                  shouldAnimate: chatProvider.getChatList.length - 1 == index,
                                );
                              }
                              return const SizedBox.shrink();
                            }),
                      ),
                       ImageIcon(
                        color: isDark ? AppMainColors.whiteColor : AppMainColors.darkColor,
                        AssetImage(Assets.imagesArrowForward2),
                      ),
                    ],
                  ),
                ),
              ),
            const MyDivider(horizontal: 20),
            const Spacer(),
            const MyDivider(),
            Container(
              height: 316.h,
              width: 375.w,
              margin: const EdgeInsetsDirectional.symmetric(
                horizontal: 12,
              ),
              decoration: const BoxDecoration(
                  // color: AppMainColors.darkColor,
                  ),
              child: Column(
                children: [
                  ListOfOptions(
                    imageIcon: Assets.imagesDelete,
                    text: 'Clear conversations',
                    function: () {
                      ApiService.deleteMessage(context: context);
                      if (kDebugMode) {
                        print('conversations');
                      }
                    },
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Expanded(
                        child: ListOfOptions(
                          function: () async {
                            if (kDebugMode) {
                              print('Upgrade');
                            }
                            Uri url = Uri.parse("https://platform.openai.com/account/billing/overview");
                            if (!await launchUrl(url)) {
                              throw 'Could not launch $url';
                            }
                          },
                          imageIcon: Assets.imagesUser,
                          text: 'Upgrade to Plus',
                        ),
                      ),
                      Container(
                        width: 46.w,
                        height: 20.h,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0.50),
                        decoration: ShapeDecoration(
                          // color: const Color(0xFFFAF3AD),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'NEW',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: isDark ? AppMainColors.whiteColor : AppMainColors.darkColor,
                                  ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8.h),
                  ListOfOptions(
                    function: () {
                      if (kDebugMode) {
                        print('mode');
                        print('isDark $isDark');
                      }
                      setState(() {
                        isDark = !isDark;
                      });
                    },
                    imageIcon: Assets.imagesSun,
                    text: 'Light mode',
                  ),
                  SizedBox(height: 8.h),
                  ListOfOptions(
                    function: () async {
                      if (kDebugMode) {
                        print('Updates');
                      }

                      Uri url = Uri.parse("https://takeielts.britishcouncil.org/take-ielts/book/ielts-online/faqs");
                      if (!await launchUrl(url)) {
                        throw 'Could not launch $url';
                      }
                    },
                    imageIcon: Assets.imagesUpdates,
                    text: 'Updates & FAQ',
                  ),
                  SizedBox(height: 8.h),
                  ListOfOptions(
                    function: () {
                      if (kDebugMode) {
                        print('Logout');

                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Log Out"),
                              content: const SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text("Sure Log Out"),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text("Log Out"),
                                  onPressed: () async {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
                                        (Route<dynamic> route) => route is OnBoardingScreen);
                                  },
                                ),
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    imageIcon: Assets.imagesLogout,
                    text: 'Logout',
                    textColor: AppMainColors.redColor,
                    iconColor: AppMainColors.redColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
