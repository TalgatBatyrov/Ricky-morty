import 'package:ricky_morty/models/character.dart';

abstract class SingleCharacterState {
  const SingleCharacterState();
}

class SingleCharacterLoading extends SingleCharacterState {}

class SingleCharacterLoaded extends SingleCharacterState {
  final Character character;

  SingleCharacterLoaded({required this.character});
}

class SingleCharacterEmpty extends SingleCharacterState {}

class SingleCharacterError extends SingleCharacterState {
  final String? error;

  SingleCharacterError({this.error});
}
