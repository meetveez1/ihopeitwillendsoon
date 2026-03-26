import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/app_enums.dart';
import '../../settings/providers/settings_provider.dart';
import '../providers/schedule_provider.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  String _day = 'Понедельник';

  @override
  Widget build(BuildContext context) {
    final asyncSchedule = ref.watch(scheduleProvider);
    final role = ref.watch(settingsProvider).settings.role;
    final days = const ['Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница'];

    return Scaffold(
      appBar: AppBar(title: const Text('Расписание')),
      floatingActionButton: role == UserRole.admin
          ? FloatingActionButton.extended(onPressed: () {}, label: const Text('Управлять расписанием'))
          : null,
      body: Column(
        children: [
          SizedBox(
            height: 56,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) {
                final day = days[i];
                final selected = day == _day;
                return ChoiceChip(
                  label: Text(day),
                  selected: selected,
                  onSelected: (_) => setState(() => _day = day),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemCount: days.length,
            ),
          ),
          Expanded(
            child: asyncSchedule.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Ошибка: $e')),
              data: (lessons) {
                final dayLessons = lessons.where((e) => e.weekday == _day).toList();
                if (dayLessons.isEmpty) return const Center(child: Text('На этот день уроков нет'));
                return ListView.builder(
                  itemCount: dayLessons.length,
                  itemBuilder: (_, i) {
                    final lesson = dayLessons[i];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text(lesson.subject),
                        subtitle: Text('${lesson.time} • Каб. ${lesson.room}\n${lesson.teacher}'),
                        isThreeLine: true,
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
