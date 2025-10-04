import 'package:flutter/material.dart';

import '../../../../app/router/routes.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/page_header.dart';

class WelcomeHomeScreen extends StatefulWidget {
  const WelcomeHomeScreen({super.key});

  @override
  State<WelcomeHomeScreen> createState() => _WelcomeHomeScreenState();
}

class _WelcomeHomeScreenState extends State<WelcomeHomeScreen> {
  final List<String> _categories = const ['All', 'Health', 'Sports', 'Music', 'Marketing'];
  int _selectedCategory = 0;

  final Map<String, List<_AssistantCardData>> _sections = {
    'Social Media': const [
      _AssistantCardData(title: 'TikTok', subtitle: 'Generate viral hook ideas', icon: Icons.play_circle_outline),
      _AssistantCardData(title: 'Telegram', subtitle: 'Curate channels updates', icon: Icons.send_rounded),
      _AssistantCardData(title: 'Twitter', subtitle: 'Thread-ready summaries', icon: Icons.alternate_email_rounded),
    ],
    'Health': const [
      _AssistantCardData(title: 'Medicine', subtitle: 'Explain diagnostics simply', icon: Icons.medical_services_outlined),
      _AssistantCardData(title: 'Disease', subtitle: 'Answer condition FAQs', icon: Icons.coronavirus_outlined),
      _AssistantCardData(title: 'Nutrition', subtitle: 'Meal plans & macros', icon: Icons.restaurant_outlined),
    ],
    'Sports': const [
      _AssistantCardData(title: 'Playbook', subtitle: 'Game strategy insights', icon: Icons.sports_soccer_outlined),
      _AssistantCardData(title: 'Analytics', subtitle: 'Crunch match stats', icon: Icons.bar_chart_rounded),
      _AssistantCardData(title: 'Commentary', subtitle: 'Generate highlight scripts', icon: Icons.mic_none_outlined),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                child: AppPageHeader(
                  title: 'AI Assistant',
                  subtitle: Text(
                    'Browse curated copilots by domain, ready to deploy instantly.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  actions: const [
                    AppIconButton(
                      icon: Icon(Icons.search_rounded),
                    ),
                  ],
                  showBack: false,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final selected = index == _selectedCategory;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: selected ? Colors.transparent : AppColors.border),
                        boxShadow: selected
                            ? const [
                                BoxShadow(
                                  color: AppColors.shadow,
                                  blurRadius: 20,
                                  offset: Offset(0, 12),
                                ),
                              ]
                            : const [],
                      ),
                      child: Center(
                        child: Text(
                          _categories[index],
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: selected ? Colors.white : AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ).inkWell(onTap: () => setState(() => _selectedCategory = index));
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemCount: _categories.length,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              sliver: SliverList.separated(
                itemBuilder: (context, index) {
                  final entry = _sections.entries.elementAt(index);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(
                        title: entry.key,
                        action: AppIconButton(
                          icon: const Icon(Icons.arrow_forward_rounded),
                          isTonal: true,
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 156,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: entry.value.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 16),
                          itemBuilder: (context, cardIndex) {
                            final data = entry.value[cardIndex];
                            return _AssistantCard(data: data);
                          },
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 28),
                itemCount: _sections.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AppButton(
        label: 'Manage assistants',
        variant: AppButtonVariant.secondary,
        expand: false,
        leading: const Icon(Icons.dashboard_customize_rounded),
        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.chatbots),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _AssistantCardData {
  const _AssistantCardData({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;
}

class _AssistantCard extends StatelessWidget {
  const _AssistantCard({required this.data});

  final _AssistantCardData data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.chatRoom),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 132,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F0F172A),
              blurRadius: 20,
              offset: Offset(0, 16),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(data.icon, color: AppColors.primary),
            ),
            const Spacer(),
            Text(
              data.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              data.subtitle,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

extension WidgetInkWell on Widget {
  Widget inkWell({VoidCallback? onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: this,
      ),
    );
  }
}


