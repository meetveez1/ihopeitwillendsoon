import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../models/app_enums.dart';
import '../../settings/providers/settings_provider.dart';
import '../providers/news_provider.dart';

class NewsScreen extends ConsumerStatefulWidget {
  const NewsScreen({super.key});

  @override
  ConsumerState<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends ConsumerState<NewsScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final asyncNews = ref.watch(newsProvider);
    final role = ref.watch(settingsProvider).settings.role;

    return Scaffold(
      appBar: AppBar(title: const Text('Новости')),
      floatingActionButton: role == UserRole.admin
          ? FloatingActionButton.extended(onPressed: () {}, icon: const Icon(Icons.add), label: const Text('Добавить новость'))
          : null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (v) => setState(() => _query = v.toLowerCase()),
              decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Поиск или категория...'),
            ),
          ),
          Expanded(
            child: asyncNews.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Ошибка: $e')),
              data: (items) {
                final filtered = items
                    .where((n) => n.title.toLowerCase().contains(_query) || n.category.toLowerCase().contains(_query))
                    .toList();
                if (filtered.isEmpty) return const Center(child: Text('Новости не найдены'));
                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (_, i) {
                    final item = filtered[i];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(item.imageUrl, width: 64, height: 64, fit: BoxFit.cover),
                        ),
                        title: Text(item.title),
                        subtitle: Text('${item.date} • ${item.summary}'),
                        onTap: () => context.push('/news/${item.id}'),
                        trailing: role == UserRole.admin ? IconButton(icon: const Icon(Icons.edit), onPressed: () {}) : null,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
