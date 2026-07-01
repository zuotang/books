import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/library/presentation/pages/collection_page.dart';
import '../../features/library/presentation/pages/library_page.dart';
import '../../features/library/presentation/pages/library_manage_page.dart';
import '../../features/library/presentation/pages/reader_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'library',
      builder: (context, state) => const LibraryPage(),
      routes: <RouteBase>[
        GoRoute(
          path: 'collection/:categoryId',
          name: 'collection',
          builder: (context, state) {
            final categoryId = state.pathParameters['categoryId'] ?? '';
            return CollectionPage(categoryId: categoryId);
          },
        ),
        GoRoute(
          path: 'manage',
          name: 'manage',
          builder: (context, state) => const LibraryManagePage(),
        ),
        GoRoute(
          path: 'reader/:bookId',
          name: 'reader',
          builder: (context, state) {
            final bookId = state.pathParameters['bookId'] ?? '';
            final chapterId = state.uri.queryParameters['chapter'];
            return ReaderPage(
              bookId: bookId,
              chapterId: chapterId,
            );
          },
        ),
        GoRoute(
          path: 'settings',
          name: 'settings',
          pageBuilder: (context, state) {
            return const MaterialPage<void>(
              child: SettingsPage(),
            );
          },
        ),
      ],
    ),
  ],
);
