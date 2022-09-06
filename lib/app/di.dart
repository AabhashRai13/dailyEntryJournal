import 'package:get_it/get_it.dart';
import 'package:reaching_our_goals/data/local/answer_dao.dart';
import 'package:reaching_our_goals/data/local/app_database_provider.dart';
import 'package:reaching_our_goals/data/local/journals_dao.dart';
import 'package:reaching_our_goals/presentation/bloc/journal_cubit/journal_cubit.dart';

import '../presentation/bloc/answer_cubit/answer_cubit.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  ///database
  instance.registerSingleton<AppDatabaseProvider>(AppDatabaseProvider());
  instance.registerSingleton<AnswerDao>(AnswerDao(instance()));

  instance.registerSingleton<JournalsDao>(JournalsDao(instance()));

  ///Cubit
  instance.registerFactory<AnswerCubit>(() => AnswerCubit());
  instance.registerSingleton<JournalCubit>(JournalCubit());
}
