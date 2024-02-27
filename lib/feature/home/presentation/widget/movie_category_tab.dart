import 'package:flutter/material.dart';

import '../../../../core/presentation/extension/build_context_extension.dart';
import '../../../../core/presentation/widget/shimmer_widget.dart';
import '../../../../core/domain/common/model/model.dart';

typedef OnCategoryItemTap = Function(GenreModel category);

class MovieCategoryTab extends StatelessWidget {
  final GenreModel category;
  final OnCategoryItemTap onTap;
  final bool isSelected;

  const MovieCategoryTab({
    super.key,
    required this.category,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(category),
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          category.name,
          style: context.titleMedium?.copyWith(
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class MovieCategoryTabShimmer extends StatelessWidget {
  const MovieCategoryTabShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShimmerWidget(
      width: 100,
      height: 24,
      radius: 16,
    );
  }
}
