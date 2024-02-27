import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/data/constant/url_constant.dart';
import '../../../../core/domain/common/model/movie_credits_casts_model.dart';
import '../../../../core/presentation/constant/image_url.dart';
import '../../../../core/presentation/extension/extension.dart';
import '../../../../core/presentation/widget/widget.dart';

class ActorWidget extends StatelessWidget {
  const ActorWidget({
    super.key,
    required this.actor,
  });

  final MovieCreditsCastModel actor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.colorScheme.onBackground.withOpacity(0.1),
        ),
      ),
      width: 110,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ImageNetwork(
              actor.profilePath?.w500Image ?? ImageUrlConstant.defaultUser,
              width: 110,
              height: 138,
              fit: BoxFit.cover,
            ),
          ),
          const Gap(12),
          Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Text(
                actor.name,
                style: context.labelMedium,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
