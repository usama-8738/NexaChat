import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../shared/widgets/page_header.dart';

class InstructionsScreen extends StatelessWidget {
  const InstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'TikTok': [
        'Hook your audience with a bold pattern interrupt in the first 2 seconds.',
        'Surface 3 key talking points formatted for on-screen captions.',
        'End with an interactive CTA designed for vertical video.',
      ],
      'Telegram': [
        'Introduce the assistant and tone in a one-line opener.',
        'Highlight 3 quick commands community members can try.',
        'Prompt users to share feedback for iterating the bot.',
      ],
      'Health': [
        'Clarify that responses are informational and not medical diagnosis.',
        'Pull in hydration, movement and rest reminders automatically.',
        'Offer follow-up questions to keep the journey personalised.',
      ],
    };

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                child: AppPageHeader(
                  title: 'Instruction playbooks',
                  subtitle: Text(
                    'Use these templates to tune outputs for each channel.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.textSecondary),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x08000000),
                      blurRadius: 20,
                      offset: Offset(0, 16),
                    ),
                  ],
                ),
                child: TabBar(
                  isScrollable: true,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  indicator: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: AppColors.textSecondary,
                  tabs: tabs.keys.map((key) => Tab(text: key)).toList(),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  children: tabs.values.map((items) {
                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 120),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x07000000),
                                blurRadius: 24,
                                offset: Offset(0, 18),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: AppColors.surfaceMuted,
                                child: Text('${index + 1}',
                                    style: Theme.of(context).textTheme.titleMedium),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  items[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(color: AppColors.textPrimary),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemCount: items.length,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

