import 'package:bank_sha/models/tip_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/theme.dart';

class HomeTipsItem extends StatelessWidget {
  final TipModel tip;

  const HomeTipsItem({
    super.key,
    required this.tip,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var url_launcher = Uri.parse(tip.url.toString());
        if (await canLaunchUrl(url_launcher)) {
          launchUrl(url_launcher);
        }
      },
      child: Container(
        width: 155,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppTheme.whiteColor,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Image.network(
                tip.thumbnail.toString(),
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                tip.title.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.blackTextStyle
                    .copyWith(fontWeight: AppTheme.medium),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
