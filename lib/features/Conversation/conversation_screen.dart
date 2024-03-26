import 'package:chat_gpt_task/image_assets.dart';
import 'package:chat_gpt_task/features/Conversation/widgets/chat_widget.dart';
import 'package:chat_gpt_task/shared/components/my_divider.dart';
import 'package:chat_gpt_task/shared/components/navigator.dart';
import 'package:chat_gpt_task/shared/components/text_form_field.dart';
import 'package:chat_gpt_task/features/Conversation/widgets/text_widget.dart';
import 'package:chat_gpt_task/shared/providers/chats_provider.dart';
import 'package:chat_gpt_task/shared/providers/models_provider.dart';
import 'package:chat_gpt_task/shared/style/color.dart';
import 'package:chat_gpt_task/shared/style/enum/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  bool _isTyping = false;

  late TextEditingController textEditingController;
  late ScrollController _listScrollController;
  late FocusNode focusNode;

  @override
  void initState() {
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      backgroundColor: isDark ? AppMainColors.darkColor : AppMainColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        leadingWidth: double.infinity,
        automaticallyImplyLeading: false,
        backgroundColor: isDark ? AppMainColors.secondColor : AppMainColors.whiteColor,
        leading: Container(
          width: 335,
          height: 64,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    padding: EdgeInsetsDirectional.zero,
                    icon: ImageIcon(
                      AssetImage(
                        Assets.imagesArrowBack,
                      ),
                      color: isDark ? AppMainColors.whiteColor : AppMainColors.secondColor,
                    ),
                    onPressed: () {
                      pop(context);
                    },
                  ),
                  Text(
                    'Back',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                      color: isDark ? AppMainColors.whiteColor : AppMainColors.secondColor,
                        ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    Assets.imagesLogo,
                    color: isDark ? AppMainColors.whiteColor : AppMainColors.darkColor,
                  ),
                  const SizedBox(width: 5),
                ],
              ),
              const MyDivider(),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: chatProvider.chatList.isEmpty ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                chatProvider.chatList.isEmpty ? const Spacer() : const SizedBox(),
                chatProvider.chatList.isEmpty
                    ? Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Ask anything, get your answer',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: isDark ? AppMainColors.whiteColor : AppMainColors.darkColor,
                                //     .withOpacity(0.4000000059604645),
                              ),
                        ),
                      )
                    : Flexible(
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                controller: _listScrollController,
                                itemCount: chatProvider.getChatList.length,
                                //chatList.length,
                                itemBuilder: (context, index) {
                                  return ChatWidget(
                                    msg: chatProvider.getChatList[index].msg, // chatList[index].msg,
                                    chatIndex: chatProvider.getChatList[index].chatIndex, //chatList[index].chatIndex,
                                    shouldAnimate: chatProvider.getChatList.length - 1 == index,
                                  );
                                },
                                separatorBuilder: (context, index) => SizedBox(height: 8.h),
                              ),
                            ),
                            if (!_isTyping)
                              Container(
                                width: 195.w,
                                height: 30,
                                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                                decoration: ShapeDecoration(
                                  color: AppMainColors.darkColor,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      strokeAlign: BorderSide.strokeAlignCenter,
                                      color: isDark
                                          ? AppMainColors.whiteColor
                                          : AppMainColors.darkColor.withOpacity(0.20000000298023224),
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(),
                                      child: Stack(children: [
                                        ImageIcon(
                                          const AssetImage(
                                            Assets.imagesRegenerate,
                                          ),
                                          color: isDark ? AppMainColors.whiteColor : AppMainColors.darkColor,
                                        ),
                                      ]),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Regenerate response',
                                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: isDark ? AppMainColors.whiteColor : AppMainColors.darkColor,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                if (_isTyping) ...[
                  Container(
                    width: 61,
                    height: 43,
                    padding: const EdgeInsets.all(12),
                    decoration: ShapeDecoration(
                      color: isDark ? AppMainColors.whiteColor : AppMainColors.darkColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                    ),
                    child: SpinKitThreeBounce(
                      color: isDark ? AppMainColors.whiteColor : AppMainColors.darkColor,
                      size: 18,
                    ),
                  ),
                ],
                const SizedBox(
                  height: 15,
                ),
                chatProvider.chatList.isEmpty ? const Spacer() : const SizedBox(),
                DefaultTextFormField(
                  controller: textEditingController,
                  keyboardType: TextInputType.multiline,
                  suffixPressed: () async {
                    await sendMessageFCT(modelsProvider: modelsProvider, chatProvider: chatProvider);
                  },
                  validate: (String? value) {
                    if (value!.trim().isEmpty) {
                      return "Please type a message";
                    }
                    return null;
                  },
                  hint: '',
                  suffix: const AssetImage(Assets.imagesSend),
                ),
                const SizedBox(
                  height: 15,
                ),
              ]),
        ),
      ),
    );
  }

  void scrollListToEND() {
    _listScrollController.animateTo(_listScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2), curve: Curves.easeOut);
  }

  Future<void> sendMessageFCT({required ModelsProvider modelsProvider, required ChatProvider chatProvider}) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "You cant send multiple messages at a time",
          ),
          // backgroundColor: AppMainColors.redColor,
        ),
      );
      return;
    }
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(
            label: "Please type a message",
            textColor: isDark ? AppMainColors.whiteColor : AppMainColors.secondColor,
          ),
          // backgroundColor: AppMainColors.redColor,
        ),
      );
      return;
    }
    try {
      String msg = textEditingController.text;
      setState(() {
        _isTyping = true;
        chatProvider.addUserMessage(msg: msg);
        textEditingController.clear();
        focusNode.unfocus();
      });
      await chatProvider.sendMessageAndGetAnswers(msg: msg, chosenModelId: modelsProvider.getCurrentModel);
      setState(() {});
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: TextWidget(
          label: error.toString(),
        ),
        // backgroundColor: AppMainColors.redColor,
      ));
    } finally {
      setState(() {
        scrollListToEND();
        _isTyping = false;
      });
    }
  }
}
