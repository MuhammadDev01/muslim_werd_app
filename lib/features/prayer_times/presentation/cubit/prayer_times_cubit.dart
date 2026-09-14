import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_werd_app/features/prayer_times/domain/prayer_times_calculator.dart';
import 'package:muslim_werd_app/features/prayer_times/domain/repositories/prayer_times_repository.dart';
import 'package:muslim_werd_app/features/prayer_times/presentation/cubit/prayer_times_state.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  PrayerTimesCubit({required this.repository}) : super(const PrayerTimesState());

  final PrayerTimesRepository repository;

  Timer? _ticker;

  Future<void> loadPrayerTimes() async {
    final prayers = await repository.getPrayerTimes(DateTime.now());
    final result = PrayerTimesCalculator.compute(
      prayers: prayers,
      now: DateTime.now(),
    );
    emit(
      PrayerTimesState(
        prayers: prayers,
        activePrayer: result.activePrayer,
        remaining: result.remaining,
      ),
    );
    _startTicker();
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      final result = PrayerTimesCalculator.compute(
        prayers: state.prayers,
        now: DateTime.now(),
      );
      if (result.activePrayer != state.activePrayer ||
          result.remaining.inSeconds != state.remaining.inSeconds) {
        emit(
          PrayerTimesState(
            prayers: state.prayers,
            activePrayer: result.activePrayer,
            remaining: result.remaining,
          ),
        );
      }
    });
  }

  @override
  Future<void> close() {
    _ticker?.cancel();
    return super.close();
  }
}