import 'package:flutter/material.dart';
import '../models/models.dart';

class VideoCarousel extends StatelessWidget {
  final List<Video> videos;

  const VideoCarousel({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return _buildVideoCard(video, index);
        },
      ),
    );
  }

  Widget _buildVideoCard(Video video, int index) {
    final isFree = video.isFree || index == 0; // First video is always free

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () => _handleVideoTap(video, isFree),
        child: Container(
          width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Thumbnail
                _buildThumbnail(video, isFree),

                // Gradient Overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),

                // Play Button
                Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      isFree ? Icons.play_arrow : Icons.lock,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),

                // Duration Badge
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      video.duration,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Title
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          video.title,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (!isFree) ...[
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.lock_outline,
                                size: 12,
                                color: Colors.amber[400],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Unlock to watch',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.amber[400],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                // Free Badge
                if (isFree)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C5CE7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'FREE',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail(Video video, bool isFree) {
    // In production, use cached_network_image with actual thumbnail URLs
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isFree
              ? [
                  const Color(0xFF6C5CE7).withOpacity(0.6),
                  const Color(0xFF5B4BC7).withOpacity(0.3),
                ]
              : [
                  Colors.grey[800]!,
                  Colors.grey[900]!,
                ],
        ),
      ),
      child: isFree
          ? Icon(
              Icons.movie_outlined,
              size: 60,
              color: Colors.white.withOpacity(0.3),
            )
          : Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.blur_on,
                  size: 60,
                  color: Colors.white.withOpacity(0.1),
                ),
                Icon(
                  Icons.lock,
                  size: 40,
                  color: Colors.white.withOpacity(0.2),
                ),
              ],
            ),
    );
  }

  void _handleVideoTap(Video video, bool isFree) {
    // In production, this would navigate to video player or show premium dialog
    if (!isFree) {
      // Show premium upsell
      // For demo, we'll just show a snackbar
    }
  }
}
