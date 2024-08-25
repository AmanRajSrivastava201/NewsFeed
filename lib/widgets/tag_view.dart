import 'package:flutter/material.dart';
import 'package:news_feed/common/dimens.dart';

import '../common/app_color_constant.dart';
import '../common/app_constant.dart';
import '../util/theme/theme_util.dart';

class TagView extends StatelessWidget {
  final String? tagName;

  const TagView({
    super.key,
    this.tagName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimens.dp8),
      decoration: ShapeDecoration(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.dp64),
        ),
      ),
      child: Text(
        tagName ?? AppConstant.emptyValue,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: ThemeUtil.getColor(AppColorConstant.white)),
      ),
    );
  }
}
