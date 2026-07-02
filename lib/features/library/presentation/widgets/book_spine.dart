import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/book_models.dart';

class BookSpine extends StatelessWidget {
  const BookSpine({
    super.key,
    required this.book,
    required this.width,
    required this.height,
    this.rotationY = -0.06,
    this.readingProgress,
    this.showTitle = true,
    this.onTap,
  });

  final Book book;
  final double width;
  final double height;
  final double rotationY;
  final ReadingProgress? readingProgress;
  final bool showTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
        child: Transform(
        alignment: Alignment.centerLeft,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(rotationY),
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                left: -6,
                top: 4,
                bottom: 4,
                child: Container(
                  width: 8,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(4),
                    ),
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.black.withValues(alpha: 0.35),
                        Colors.white.withValues(alpha: 0.08),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 2,
                right: 2,
                top: -4,
                child: Transform(
                  transform: Matrix4.skewX(-0.55),
                  child: Container(
                    height: 7,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(4),
                      ),
                      gradient: LinearGradient(
                        colors: <Color>[
                          Colors.white.withValues(alpha: 0.72),
                          Colors.black.withValues(alpha: 0.12),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: book.coverColors,
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.18),
                        blurRadius: 18,
                        offset: const Offset(10, 12),
                      ),
                    ],
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[
                          Colors.white.withValues(alpha: 0.18),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.1),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 14, 10, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 18,
                            height: 2,
                            color: Colors.white.withValues(alpha: 0.78),
                          ),
                          const Spacer(),
                          if (showTitle) ...<Widget>[
                            Text(
                              book.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: Colors.white,
                                height: 1.15,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              book.author,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white.withValues(alpha: 0.72),
                              ),
                            ),
                          ] else
                            Text(
                              book.title.split(' ').first,
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          if (readingProgress != null) ...<Widget>[
                            const SizedBox(height: 8),
                            _BookProgressBadge(progress: readingProgress!),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: AppColors.paperSoft.withValues(alpha: 0.22),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookProgressBadge extends StatelessWidget {
  const _BookProgressBadge({
    required this.progress,
  });

  final ReadingProgress progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chapterLabel = (progress.chapterLabel?.trim().isNotEmpty ?? false)
        ? progress.chapterLabel!.trim()
        : '未开始';
    final percent = (progress.progress * 100).clamp(0, 100).toStringAsFixed(0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.24),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            chapterLabel,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontSize: 10,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '第${progress.pageIndex + 1}页 · $percent%',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.84),
              fontSize: 10,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}
