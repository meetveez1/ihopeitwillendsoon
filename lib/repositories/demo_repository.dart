import '../models/news_item.dart';
import '../models/schedule_item.dart';

class DemoRepository {
  Future<List<NewsItem>> fetchNews() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const [
      NewsItem(
        id: '1',
        title: 'Городская олимпиада по математике',
        imageUrl: 'https://images.unsplash.com/photo-1503676260728-1c00da094a0b',
        category: 'Олимпиады',
        date: '2026-03-20',
        summary: 'Наши ученики заняли призовые места на городской олимпиаде.',
        content: 'Команда школы показала высокий результат и заняла 2 место в командном зачете.',
      ),
      NewsItem(
        id: '2',
        title: 'Весенний фестиваль науки',
        imageUrl: 'https://images.unsplash.com/photo-1544717305-2782549b5136',
        category: 'События',
        date: '2026-03-18',
        summary: 'Приглашаем всех на фестиваль науки в актовом зале.',
        content: 'В программе: мастер-классы, демонстрации экспериментов и выставка проектов.',
      ),
      NewsItem(
        id: '3',
        title: 'Обновление школьного расписания',
        imageUrl: 'https://images.unsplash.com/photo-1434030216411-0b793f4b4173',
        category: 'Объявления',
        date: '2026-03-15',
        summary: 'С понедельника изменяются занятия в кабинетах 204 и 305.',
        content: 'Пожалуйста, проверьте изменения в разделе расписания, чтобы не пропустить урок.',
      ),
    ];
  }

  Future<List<ScheduleItem>> fetchSchedule() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const [
      ScheduleItem(id: 's1', weekday: 'Понедельник', subject: 'Математика', time: '08:30-09:15', room: '204', teacher: 'Иванова Н.А.'),
      ScheduleItem(id: 's2', weekday: 'Понедельник', subject: 'Физика', time: '09:25-10:10', room: '305', teacher: 'Петров И.С.'),
      ScheduleItem(id: 's3', weekday: 'Вторник', subject: 'Литература', time: '08:30-09:15', room: '110', teacher: 'Смирнова Л.В.'),
      ScheduleItem(id: 's4', weekday: 'Среда', subject: 'Информатика', time: '10:20-11:05', room: '401', teacher: 'Морозов А.К.'),
      ScheduleItem(id: 's5', weekday: 'Четверг', subject: 'История', time: '11:15-12:00', room: '212', teacher: 'Соколов Д.П.'),
      ScheduleItem(id: 's6', weekday: 'Пятница', subject: 'Английский язык', time: '12:20-13:05', room: '118', teacher: 'Кузнецова Е.В.'),
    ];
  }
}
