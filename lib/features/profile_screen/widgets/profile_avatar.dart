import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final VoidCallback? onEdit;

  const ProfileAvatar({
    super.key,
    this.imageUrl,
    this.radius = 50,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const borderThickness = 4.0;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: radius * 2 + borderThickness,
          height: radius * 2 + borderThickness,
          padding: const EdgeInsets.all(borderThickness / 1),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: theme.colorScheme.primary,
              width: borderThickness,
            ),
          ),
          child: CircleAvatar(
            radius: radius,
            backgroundColor: theme.colorScheme.secondary.withOpacity(0.1),
            backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
                ? CachedNetworkImageProvider(imageUrl!) as ImageProvider
                : const AssetImage('assets/images/default_avatar.png'),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 4,
          child: GestureDetector(
            onTap: onEdit,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: theme.colorScheme.primary,
              child: const Icon(
                Icons.edit,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
