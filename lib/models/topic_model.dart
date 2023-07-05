import 'package:equatable/equatable.dart';

class TopicModel extends Equatable {
  final String topic;
  final String character;

  const TopicModel(
    this.topic,
    this.character,
  );

  @override
  List<Object?> get props => [character];
}
