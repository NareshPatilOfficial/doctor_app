import 'package:doctorbridge_mobile_ui/features/patient/data/models/user_profile_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_account_state.freezed.dart';

@freezed
abstract class PatientAccountState with _$PatientAccountState {
  const factory PatientAccountState.inactive() = _Inactive;
  const factory PatientAccountState.loading() = _Loading;
  const factory PatientAccountState.ready({
    required List<int> linkedUserIds,
    required int activeUserId,
    required UserProfileDto profile,
  }) = _Ready;
}
