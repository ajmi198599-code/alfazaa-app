import 'package:flutter/material.dart';

import '../models/provider_profile.dart';
import 'provider_card.dart';

class NearbyProviderCard extends StatelessWidget {
  const NearbyProviderCard({
    super.key,
    required this.provider,
    this.highlight = false,
    this.onTap,
  });

  final AlfazaaProvider provider;
  final bool highlight;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ProviderCard(
      provider: provider,
      highlight: highlight,
      onTap: onTap,
    );
  }
}
