import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/personality_model.dart';

class VideoCard extends StatelessWidget {
  final PersonalityVideo video;
  final bool isPremium;

  const VideoCard({
    Key? key,
    required this.video,
    this.isPremium = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isPremium
          ? () => _showPremiumDialog(context)
          : () => _showVideoPlayer(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(0xFF0f3460),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: video.thumbnailUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Color(0xFF0f3460),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF00d4ff),
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Color(0xFF0f3460),
                  child: Icon(
                    Icons.video_library,
                    color: Colors.grey[700],
                    size: 48,
                  ),
                ),
              ),
            ),

            // Overlay
            if (isPremium)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

            // Content
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Play Button or Lock Icon
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xFF00d4ff),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isPremium ? Icons.lock : Icons.play_arrow,
                      color: Color(0xFF1a1a2e),
                      size: 28,
                    ),
                  ),
                  if (isPremium) ...[
                    SizedBox(height: 12),
                    Text(
                      'Premium Only',
                      style: TextStyle(
                        color: Color(0xFF00d4ff),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Title at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                padding: EdgeInsets.all(12),
                child: Text(
                  video.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showVideoPlayer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF1a1a2e),
      builder: (context) => Container(
        height: 400,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              video.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Color(0xFF0f3460),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  Icons.play_arrow,
                  color: Color(0xFF00d4ff),
                  size: 64,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Video Player',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPremiumDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1a1a2e),
        title: Text(
          'Premium Content',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Unlock this video and more with Premium membership',
          style: TextStyle(color: Colors.grey[300]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/premium');
            },
            child: Text(
              'Upgrade',
              style: TextStyle(color: Color(0xFF00d4ff)),
            ),
          ),
        ],
      ),
    );
  }
}
