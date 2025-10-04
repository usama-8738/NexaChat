import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/page_header.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<_PlanCard> plans = [
      _PlanCard(
        name: 'Starter',
        price: '\$9',
        description: 'Perfect for creators exploring AI chat with generous limits.',
        perks: ['10 assistants', 'Unlimited history', 'Standard support'],
      ),
      _PlanCard(
        name: 'Pro',
        price: '\$29',
        description: 'Scale your team with automations, custom instructions and seats.',
        perks: ['50 assistants', 'Workflow automations', 'Priority support'],
        highlight: 'Most popular',
      ),
      _PlanCard(
        name: 'Enterprise',
        price: 'Talk to us',
        description: 'Compliance-ready deployment with custom guardrails and SSO.',
        perks: ['Unlimited assistants', 'Dedicated success partner', 'SOC2 & GDPR ready'],
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 140),
          children: [
            AppPageHeader(
              title: 'Subscriptions',
              subtitle: Text(
                'Choose a plan that matches your assistant usage.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            SizedBox(height: 12),
            ...plans,
          ],
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.name,
    required this.price,
    required this.description,
    required this.perks,
    this.highlight,
  });

  final String name;
  final String price;
  final String description;
  final List<String> perks;
  final String? highlight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isHighlighted = highlight != null;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        gradient: isHighlighted
            ? const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isHighlighted ? null : Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 28,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: isHighlighted ? Colors.white.withValues(alpha: 0.12) : Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  name,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isHighlighted ? Colors.white : AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                if (highlight != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      highlight!,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              price,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: isHighlighted ? Colors.white : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isHighlighted ? Colors.white70 : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: perks
                  .map(
                    (perk) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: isHighlighted ? Colors.white : AppColors.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              perk,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: isHighlighted ? Colors.white : AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            AppButton(
              label: isHighlighted ? 'Upgrade to Pro' : 'Select plan',
              variant: isHighlighted ? AppButtonVariant.primary : AppButtonVariant.secondary,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}


