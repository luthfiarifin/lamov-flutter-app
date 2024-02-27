import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/domain/common/model/genre_model.dart';
import 'movie_category_tab.dart';

class MovieCategoryTabList extends StatelessWidget {
  final GenreModel? selectedCategory;
  final List<GenreModel>? categories;
  final OnCategoryItemTap onTap;

  const MovieCategoryTabList({
    super.key,
    required this.selectedCategory,
    required this.categories,
    required this.onTap,
  });

  final Axis _scrollDirection = Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: categories == null
          ? ListView.separated(
              itemBuilder: (context, index) {
                return const MovieCategoryTabShimmer();
              },
              padding: _padding(),
              itemCount: 5,
              scrollDirection: _scrollDirection,
              separatorBuilder: (context, index) => const Gap(8),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                final category = categories![index];
                return MovieCategoryTab(
                  category: category,
                  onTap: onTap,
                  isSelected: category.id == selectedCategory?.id,
                );
              },
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories!.length,
              scrollDirection: _scrollDirection,
            ),
    );
  }

  EdgeInsets _padding() => const EdgeInsets.symmetric(horizontal: 16);
}
