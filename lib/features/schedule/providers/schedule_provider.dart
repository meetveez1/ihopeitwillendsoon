import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/schedule_item.dart';
import '../../news/providers/news_provider.dart';

final scheduleProvider = FutureProvider<List<ScheduleItem>>((ref) async {
  return ref.read(demoRepositoryProvider).fetchSchedule();
});
