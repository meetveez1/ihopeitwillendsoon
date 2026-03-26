import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/news_item.dart';
import '../../../repositories/demo_repository.dart';

final demoRepositoryProvider = Provider<DemoRepository>((ref) => DemoRepository());

final newsProvider = FutureProvider<List<NewsItem>>((ref) async {
  return ref.read(demoRepositoryProvider).fetchNews();
});
