import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../domain/entities/subscription_plan.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/page_header.dart';
import '../../application/subscription_providers.dart';
import '../../application/subscription_state.dart';

class SubscriptionScreen extends ConsumerStatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  ConsumerState<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends ConsumerState<SubscriptionScreen> {
  @override
  void initState() {
    super.initState();
    ref.listen<SubscriptionState>(subscriptionNotifierProvider, (previous, next) {
      if (!mounted) return;
      if (next.failure != null && next.failure != previous?.failure) {
        _showMessage(next.failure!.message);
      } else if (previous?.isProcessing == true && next.isProcessing == false && next.failure == null) {
        if (previous?.isCancelling == true) {
          _showMessage('Subscription cancelled.');
        } else if (previous?.pendingPlanId != null) {
          _showMessage('Subscription updated.');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(subscriptionNotifierProvider);
    final notifier = ref.read(subscriptionNotifierProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await notifier.loadPlans();
            await notifier.refreshSubscription();
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 140),
            children: [
              AppPageHeader(
                title: 'Subscriptions',
                subtitle: Text(
                  'Choose a plan that matches your assistant usage.',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
              if (state.isProcessing)
                const LinearProgressIndicator(minHeight: 2),
              if (state.current != null) ...[
                const SizedBox(height: 12),
                _CurrentSubscriptionCard(state: state),
              ],
              const SizedBox(height: 12),
              if (state.isLoading && state.plans.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 48),
                  child: Center(child: CircularProgressIndicator()),
                )
              else ...state.plans.map((plan) {
                final isCurrent = state.current?.plan.id == plan.id;
                final isProcessing = state.isProcessing && state.pendingPlanId == plan.id;
                return _PlanCard(
                  plan: plan,
                  isCurrent: isCurrent,
                  isRecommended: plan.isRecommended,
                  onSelect: isCurrent ? null : () => notifier.subscribe(plan.id),
                  onCancel: isCurrent && state.hasActiveSubscription ? notifier.cancel : null,
                  isProcessing: isProcessing,
                  isCancelling: state.isCancelling,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _CurrentSubscriptionCard extends StatelessWidget {
  const _CurrentSubscriptionCard({required this.state});

  final SubscriptionState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final plan = state.current?.plan;
    if (plan == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 24,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current plan',
            style: theme.textTheme.labelLarge?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 12),
          Text(
            plan.name,
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            '${state.creditsRemaining} credits remaining',
            style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
          if (state.current?.renewsAt != null) ...[
            const SizedBox(height: 6),
            Text(
              'Renews ${_formatDate(state.current!.renewsAt!)}',
              style: theme.textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ],
      ),
    );
  }

  static String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.plan,
    required this.isCurrent,
    required this.isRecommended,
    required this.onSelect,
    required this.onCancel,
    required this.isProcessing,
    required this.isCancelling,
  });

  final SubscriptionPlan plan;
  final bool isCurrent;
  final bool isRecommended;
  final VoidCallback? onSelect;
  final Future<void> Function()? onCancel;
  final bool isProcessing;
  final bool isCancelling;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final highlight = isCurrent || isRecommended;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        gradient: highlight
            ? const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: highlight ? null : Colors.white,
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
          color: highlight ? Colors.white.withOpacity(0.12) : Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  plan.name,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: highlight ? Colors.white : AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                if (isCurrent)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      'Current',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else if (isRecommended)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      'Recommended',
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
              _formatPrice(plan),
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: highlight ? Colors.white : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: plan.benefits
                  .map(
                    (perk) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: highlight ? Colors.white : AppColors.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              perk,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: highlight ? Colors.white : AppColors.textPrimary,
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
              label: isCurrent ? 'Current plan' : 'Select plan',
              variant: highlight ? AppButtonVariant.primary : AppButtonVariant.secondary,
              onPressed: isCurrent ? null : onSelect,
              isLoading: isProcessing,
            ),
            if (isCurrent)
              TextButton(
                onPressed: onCancel == null || isCancelling ? null : () => onCancel(),
                child: isCancelling
                    ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Cancel subscription'),
              ),
          ],
        ),
      ),
    );
  }

  static String _formatPrice(SubscriptionPlan plan) {
    if (plan.price <= 0) {
      return 'Included';
    }
    final value = plan.price % 1 == 0 ? plan.price.toStringAsFixed(0) : plan.price.toStringAsFixed(2);
    final symbol = plan.currency.toUpperCase() == 'USD' ? '$' : '${plan.currency} ';
    return '${symbol == '$' ? '\$' : symbol}$value/mo';
  }
}
