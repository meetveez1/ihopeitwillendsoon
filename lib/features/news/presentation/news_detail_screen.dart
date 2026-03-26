import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/news_provider.dart';

class NewsDetailScreen extends ConsumerWidget {
  final String newsId;
  const NewsDetailScreen({super.key, required this.newsId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncNews = ref.watch(newsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Детали новости')),
      body: asyncNews.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
        data: (list) {
          final item = list.firstWhere((n) => n.id == newsId);
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(item.imageUrl, height: 200, fit: BoxFit.cover),
              ),
              const SizedBox(height: 14),
              Text(item.title, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text('${item.date} • ${item.category}'),
              const SizedBox(height: 12),
              Text(item.content, style: Theme.of(context).textTheme.bodyLarge),
            ],
          );
        },
      ),
    );
  }
}
