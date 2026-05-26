import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  static const routeName = '/chat';

  static const _messages = [
    _ChatMessage(
        text: 'السلام عليكم، أنا راكان من الفزعة. في الطريق لك الآن.',
        mine: false,
        time: '8:41 م'),
    _ChatMessage(
        text: 'وعليكم السلام، موقعي عند البوابة الرئيسية.',
        mine: true,
        time: '8:42 م'),
    _ChatMessage(
        text: 'وصلت قريب، باقي 6 دقائق بإذن الله.',
        mine: false,
        time: '8:44 م'),
    _ChatMessage(text: 'تمام، بانتظارك.', mine: true, time: '8:45 م'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.screen),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
                child: Row(
                  children: [
                    IconButton(
                      tooltip: 'رجوع',
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const Icon(Icons.arrow_forward_rounded,
                          color: AppColors.white),
                    ),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        gradient: AppGradients.gold,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person_rounded,
                          color: AppColors.deepBlack),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('راكان الحربي',
                              style: Theme.of(context).textTheme.titleMedium),
                          const Text(
                            'متصل الآن • مزود موثق',
                            style: TextStyle(
                                color: AppColors.greenLight,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'اتصال',
                      onPressed: () {},
                      icon:
                          const Icon(Icons.call_rounded, color: AppColors.gold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                  itemCount: _messages.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) =>
                      _MessageBubble(message: _messages[index]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'اكتب رسالة تجريبية',
                          prefixIcon:
                              const Icon(Icons.add_circle_outline_rounded),
                          suffixIcon: IconButton(
                            tooltip: 'إرسال',
                            onPressed: () {},
                            icon: const Icon(Icons.send_rounded),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final _ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.mine ? Alignment.centerLeft : Alignment.centerRight,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.74),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: message.mine ? AppGradients.gold : AppGradients.glass,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: Radius.circular(message.mine ? 4 : 20),
              bottomRight: Radius.circular(message.mine ? 20 : 4),
            ),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.text,
                style: TextStyle(
                  color: message.mine ? AppColors.deepBlack : AppColors.white,
                  fontWeight: FontWeight.w700,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                message.time,
                style: TextStyle(
                  color: message.mine
                      ? AppColors.deepBlack.withValues(alpha: 0.62)
                      : AppColors.mutedDark,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatMessage {
  const _ChatMessage({
    required this.text,
    required this.mine,
    required this.time,
  });

  final String text;
  final bool mine;
  final String time;
}
