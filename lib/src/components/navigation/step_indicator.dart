import 'package:flutter/material.dart';

import '../../tokens/colors.dart';

/// A horizontal step-progress indicator: filled circle for completed steps,
/// a ring for the active step, a dot for pending steps, connected by lines.
/// Also known as `WizardSteps` in other parts of the Syzygy ecosystem.
class StepIndicator extends StatelessWidget {
  const StepIndicator({super.key, required this.steps, required this.currentStep});

  final List<String> steps;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Row(
      children: List.generate(steps.length, (index) {
        final isCompleted = index < currentStep;
        final isActive = index == currentStep;

        Widget marker;
        if (isCompleted) {
          marker = CircleAvatar(
            radius: 10,
            backgroundColor: colors.primary,
            child: Icon(Icons.check, size: 12, color: colors.onPrimary),
          );
        } else if (isActive) {
          marker = Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colors.primary, width: 2),
            ),
          );
        } else {
          marker = Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(shape: BoxShape.circle, color: colors.border),
          );
        }

        final isLast = index == steps.length - 1;

        return Expanded(
          flex: isLast ? 0 : 1,
          child: Row(
            children: [
              Semantics(
                label: '${steps[index]}${isCompleted ? ', completed' : isActive ? ', current' : ''}',
                child: marker,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    height: 2,
                    color: isCompleted ? colors.primary : colors.border,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
