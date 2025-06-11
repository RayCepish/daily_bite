part of 'main_page_bloc.dart';

abstract class MainPageEvent extends Equatable {
  const MainPageEvent();

  @override
  List<Object> get props => [];
}

class ChangeTabEvent extends MainPageEvent {
  final int newIndex;

  const ChangeTabEvent(this.newIndex);

  @override
  List<Object> get props => [newIndex];
}
