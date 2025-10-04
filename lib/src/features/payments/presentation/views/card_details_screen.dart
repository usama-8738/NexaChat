import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/page_header.dart';

class CardDetailsScreen extends StatelessWidget {
  const CardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 140),
          children: [
            const AppPageHeader(title: 'Card details'),
            const SizedBox(height: 16),
            const _CardDisplay(),
            const SizedBox(height: 24),
            _DetailTile(
              icon: Icons.credit_score_outlined,
              title: 'Set spending limit',
              subtitle: 'Current monthly limit: \$1200',
            ),
            const SizedBox(height: 12),
            _DetailTile(
              icon: Icons.notifications_outlined,
              title: 'Billing reminders',
              subtitle: 'Push & email reminders enabled',
            ),
            const SizedBox(height: 12),
            _DetailTile(
              icon: Icons.shield_outlined,
              title: 'Security',
              subtitle: '3D Secure and biometrics active',
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Remove card',
              variant: AppButtonVariant.secondary,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _CardDisplay extends StatelessWidget {
  const _CardDisplay();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF111827), Color(0xFF1E293B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 36,
            offset: Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.credit_card, color: Colors.white),
              Icon(Icons.more_horiz_rounded, color: Colors.white),
            ],
          ),
          const SizedBox(height: 40),
          const Text(
            '**** **** **** 8291',
            style: TextStyle(color: Colors.white, fontSize: 24, letterSpacing: 4),
          ),
          const SizedBox(height: 28),
          Row(
            children: const [
              Expanded(
                child: _CardMeta(label: 'Card holder', value: 'Sulem Freelancer'),
              ),
              Expanded(
                child: _CardMeta(label: 'Expires', value: '08/28'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardMeta extends StatelessWidget {
  const _CardMeta({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _DetailTile extends StatelessWidget {
  const _DetailTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 24,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: AppColors.textPrimary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          AppIconButton(
            icon: const Icon(Icons.chevron_right_rounded),
            onPressed: () {},
            isTonal: true,
          ),
        ],
      ),
    );
  }
}

