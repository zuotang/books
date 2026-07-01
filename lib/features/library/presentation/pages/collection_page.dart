import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/book_repository.dart';
import '../widgets/book_spine.dart';

class CollectionPage extends ConsumerWidget {
  const CollectionPage({super.key, required this.categoryId});

  final String categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryAsync = ref.watch(bookCategoryProvider(categoryId));
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: categoryAsync.when(
          data: (category) {
            if (category == null) {
              return Center(child: Text(l10n.collectionNotFound));
            }

            return CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                  sliver: SliverToBoxAdapter(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final compact = constraints.maxWidth < 420;

                        return Row(
                          children: <Widget>[
                            IconButton.filledTonal(
                              onPressed: context.pop,
                              icon: const Icon(Icons.close_rounded),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    category.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: compact
                                        ? theme.textTheme.headlineMedium
                                        : theme.textTheme.headlineLarge,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    l10n.bookCount(category.books.length),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 24,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.56,
                        ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final book = category.books[index];

                      return GestureDetector(
                        onTap: () => context.go('/reader/${book.id}'),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final coverHeight = (constraints.maxHeight - 58)
                                .clamp(96.0, 154.0);
                            final coverWidth = (coverHeight * (96 / 154)).clamp(
                              60.0,
                              96.0,
                            );

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Center(
                                    child: BookSpine(
                                      book: book,
                                      width: coverWidth,
                                      height: coverHeight,
                                      onTap: () =>
                                          context.go('/reader/${book.id}'),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  book.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.labelLarge,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  book.author,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    }, childCount: category.books.length),
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text(error.toString())),
        ),
      ),
    );
  }
}
