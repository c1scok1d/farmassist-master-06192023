import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends NewsEvent {
  final String category;

  Fetch({required this.category});
  @override
  List<Object> get props => [category];

  @override
  String toString() => 'Fetch $category news';
}
