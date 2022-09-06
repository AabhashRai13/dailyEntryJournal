import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reaching_our_goals/app/di.dart';
import 'package:reaching_our_goals/presentation/data_entry/data_entry_view.dart';
import 'package:reaching_our_goals/presentation/information/info_page.dart';
import 'package:reaching_our_goals/resources/assets_manager.dart';
import 'package:reaching_our_goals/resources/color_manager.dart';
import 'package:reaching_our_goals/resources/font_manager.dart';
import 'package:reaching_our_goals/resources/styles_manager.dart';
import 'package:intl/intl.dart';
import '../bloc/journal_cubit/journal_cubit.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class JournalsList extends StatefulWidget {
  const JournalsList({Key? key}) : super(key: key);

  @override
  State<JournalsList> createState() => _JournalsListState();
}

class _JournalsListState extends State<JournalsList> {
  final JournalCubit _journalCubit = instance<JournalCubit>();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      _journalCubit.getJournals();
    });
  }

  doNothing() {
    log("fick you");
  }

  navigateToEdit(JournalState state, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DataEntryView(
                journal: state.journal[index],
                isNew: false,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Your Journal"), actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InfoPage()),
                );
              },
              icon: const Icon(Icons.question_mark))
        ]),
        body: BlocBuilder<JournalCubit, JournalState>(
          bloc: BlocProvider.of<JournalCubit>(context),
          builder: (context, state) {
            if (state.journal.isEmpty) {
              return Column(
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: const Image(
                        image: AssetImage(ImageAssets.appLogo),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Tap the calendar icon to add a new journal entry.",
                      style: getBoldStyle(color: ColorManager.primary),
                    ),
                  ),
                ],
              );
            } else {
              return ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.14,
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: const Image(
                        image: AssetImage(ImageAssets.appLogo),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: state.journal.length,
                        itemBuilder: ((context, index) {
                          return Slidable(
                            // Specify a key if the Slidable is dismissible.
                            key: const ValueKey(0),

                            // The start action pane is the one at the left or the top side.
                            startActionPane: ActionPane(
                              // A motion is a widget used to control how the pane animates.
                              motion: const ScrollMotion(),

                              // A pane can dismiss the Slidable.
                              dismissible: DismissiblePane(onDismissed: () {
                                _journalCubit.deleteJournal(
                                    DateFormat("yyyy-MM-dd HH:mm:ss").format(
                                        state.journal[index].dateTime!));
                                setState(() {
                                  state.journal.removeAt(index);
                                });
                              }),

                              // All actions are defined in the children parameter.
                              children: [
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  onPressed: ((context) {
                                    _journalCubit.deleteJournal(DateFormat(
                                            "yyyy-MM-dd HH:mm:ss")
                                        .format(
                                            state.journal[index].dateTime!));
                                    setState(() {
                                      state.journal.removeAt(index);
                                    });
                                  }),
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                                SlidableAction(
                                  onPressed: ((context) =>
                                      navigateToEdit(state, index)),
                                  backgroundColor: const Color(0xFF21B7CA),
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: 'Edit',
                                ),
                              ],
                            ),

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DataEntryView(
                                              journal: state.journal[index],
                                              isNew: false,
                                            )),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            DateFormat.MMMEd().format(
                                                state.journal[index].dateTime!),
                                            style: getBoldStyle(
                                                color: ColorManager.primary,
                                                fontSize: FontSize.s18),
                                          ),
                                          Text(
                                            DateFormat.jm().format(
                                                state.journal[index].dateTime!),
                                            style: getSemiBoldStyle(
                                                color: ColorManager.primary,
                                                fontSize: FontSize.s14),
                                          ),
                                          Text(
                                            "Continue working on ${state.journal[index].answers![0].value!}",
                                            style: getMediumStyle(
                                                color: ColorManager.primary),
                                          ),
                                          const Divider()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                ],
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorManager.primary,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const DataEntryView(
                        isNew: true,
                      )),
            );
          },
          child: const Icon(
            Icons.edit_calendar_outlined,
          ),
        ));
  }
}
