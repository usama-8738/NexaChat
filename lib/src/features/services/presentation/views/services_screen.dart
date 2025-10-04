import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/page_header.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = const [
      _ServiceCardData(
        title: 'Content Studio',
        description: 'Generate viral-ready scripts, outlines and captions for every platform.',
        icon: Icons.play_circle_outline,
        color: Color(0xFF6366F1),
      ),
      _ServiceCardData(
        title: 'Health Coach',
        description: 'Personalised wellness routines, habit tracking and nudges.',
        icon: Icons.favorite_outline,
        color: Color(0xFF34D399),
      ),
      _ServiceCardData(
        title: 'Growth Mentor',
        description: 'Insights to scale your business with experiments and messaging.',
        icon: Icons.trending_up_rounded,
        color: Color(0xFFF97316),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 140),
          children: [
            AppPageHeader(
              title: 'AI services',
              subtitle: Text(
                'Bundles of assistants designed to cover outcomes end-to-end.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(height: 16),
            ...services.map((service) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _ServiceCard(data: service),
                )),
          ],
        ),
      ),
    );
  }
}

class _ServiceCardData {
  const _ServiceCardData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.data});

  final _ServiceCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 28,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: data.color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(data.icon, color: data.color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  data.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              AppIconButton(
                icon: const Icon(Icons.chevron_right_rounded),
                onPressed: () {},
                isTonal: true,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            data.description,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
          AppButton(
            label: 'View playbooks',
            variant: AppButtonVariant.secondary,
            expand: false,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

