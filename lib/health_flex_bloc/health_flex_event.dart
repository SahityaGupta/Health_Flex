part of 'health_flex_bloc.dart';

abstract class HealthFlexEvent extends Equatable {
  const HealthFlexEvent();
}

class HealthFlexInitial extends HealthFlexEvent {
  @override
  List<Object> get props => [];
}

class HealthFlexTrendingEvent extends HealthFlexEvent {

  @override
  List<Object> get props => [];
}