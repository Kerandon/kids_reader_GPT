import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TopicModel extends Equatable {
  final String name;
  final Offset originalOffset;
  final Offset droppedOffset;
  final Velocity droppedVelocity;
  final bool isDragged;
  final int? placedPosition;

  const TopicModel(
    this.name, {
    this.originalOffset = Offset.zero,
    this.droppedOffset = Offset.zero,
    this.droppedVelocity = Velocity.zero,
    this.isDragged = false,
    this.placedPosition,
  });

  TopicModel copyWith({
    Offset? originalOffset,
    Offset? droppedOffset,
    Velocity? droppedVelocity,
    bool? isDragged,
    int? placedPosition,
  }) {
    return TopicModel(
      name,
      originalOffset: originalOffset ?? this.originalOffset,
      droppedOffset: droppedOffset ?? this.droppedOffset,
      droppedVelocity: droppedVelocity ?? this.droppedVelocity,
      isDragged: isDragged ?? this.isDragged,
      placedPosition: placedPosition ?? this.placedPosition,
    );
  }

  @override
  List<Object?> get props => [name];
}
