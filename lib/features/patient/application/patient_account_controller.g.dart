// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_account_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientAccountController)
const patientAccountControllerProvider = PatientAccountControllerProvider._();

final class PatientAccountControllerProvider
    extends $NotifierProvider<PatientAccountController, PatientAccountState> {
  const PatientAccountControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'patientAccountControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$patientAccountControllerHash();

  @$internal
  @override
  PatientAccountController create() => PatientAccountController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PatientAccountState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PatientAccountState>(value),
    );
  }
}

String _$patientAccountControllerHash() =>
    r'444d6f3d7527cfabfefd7b6221162accd38ca525';

abstract class _$PatientAccountController
    extends $Notifier<PatientAccountState> {
  PatientAccountState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PatientAccountState, PatientAccountState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PatientAccountState, PatientAccountState>,
              PatientAccountState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
