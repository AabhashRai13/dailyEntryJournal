import 'package:flutter/material.dart';
import 'package:reaching_our_goals/presentation/bloc/answer_cubit/answer_cubit.dart';
import 'package:reaching_our_goals/presentation/bloc/journal_cubit/journal_cubit.dart';
import 'package:reaching_our_goals/presentation/journals_list.dart/journals_list.dart';
import 'package:reaching_our_goals/resources/theme_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initAppModule();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AnswerCubit _answerCubit;
  late JournalCubit _journalCubit;
  @override
  void initState() {
    super.initState();
    _answerCubit = instance<AnswerCubit>();
    _journalCubit = instance<JournalCubit>();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _answerCubit),
        BlocProvider.value(value: _journalCubit),
      ],
      child: MaterialApp(
        title: 'Reaching Our Goals',
        theme: getApplicationTheme(),
        home: const JournalsList(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
