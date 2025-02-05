part of 'main_bloc.dart';

/// Here is where I added all the events that I need for this widget.
class MainEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCategories extends MainEvent {}

class SelectCategory extends MainEvent {
  final int idSelected;

  SelectCategory({required this.idSelected});

  @override
  List<Object?> get props => [idSelected];
}