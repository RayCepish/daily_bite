part of 'main_page_bloc.dart';

class MainPageState extends Equatable {
  final int currentIndex;

  const MainPageState({required this.currentIndex});

  MainPageState copyWith({int? currentIndex}) {
    return MainPageState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object> get props => [currentIndex];
}
