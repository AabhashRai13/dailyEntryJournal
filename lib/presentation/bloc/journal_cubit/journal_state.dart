part of 'journal_cubit.dart';

class JournalState extends Equatable {
  final List<Journal> journal;
  const JournalState({
    required this.journal,
  });

  @override
  List<Object> get props => [journal];
}
