// =============================================================================
// token_storage.dart — Secure persistence for tokens and cached user
// =============================================================================
// Abstract [TokenStorage] + [SecureTokenStorage] using flutter_secure_storage.
// [tokenStorageProvider] supplies the live implementation. Widgets should not
// touch storage directly; use [SessionController] or repositories.
// =============================================================================

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'user.dart';

part 'token_storage.g.dart';

abstract class TokenStorage {
  Future<String?> readAccessToken();
  Future<String?> readRefreshToken();
  Future<User?> readUser();
  Future<void> persistSession({
    required String accessToken,
    String? refreshToken,
    required User user,
  });
  Future<void> clearSession();

  /// Patient multi-account: linked user ids from login + currently selected id.
  Future<void> persistPatientLinkedAccounts({
    required List<int> userIds,
    required int activeUserId,
  });
  Future<({List<int> userIds, int activeUserId})?> readPatientLinkedAccounts();
  Future<void> clearPatientLinkedAccounts();
}

@Riverpod(keepAlive: true)
TokenStorage tokenStorage(Ref ref) => SecureTokenStorage(const FlutterSecureStorage());

class SecureTokenStorage implements TokenStorage {
  SecureTokenStorage(this._storage);

  final FlutterSecureStorage _storage;

  static const _kAccess = 'doctorbridge_access_token';
  static const _kRefresh = 'doctorbridge_refresh_token';
  static const _kUser = 'doctorbridge_user_json';
  static const _kPatientUserIds = 'doctorbridge_patient_user_ids_json';
  static const _kActivePatientUserId = 'doctorbridge_active_patient_user_id';

  @override
  Future<String?> readAccessToken() => _storage.read(key: _kAccess);

  @override
  Future<String?> readRefreshToken() => _storage.read(key: _kRefresh);

  @override
  Future<User?> readUser() async {
    final raw = await _storage.read(key: _kUser);
    if (raw == null || raw.isEmpty) {
      return null;
    }
    try {
      return User.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } on Object {
      return null;
    }
  }

  @override
  Future<void> persistSession({
    required String accessToken,
    String? refreshToken,
    required User user,
  }) async {
    await _storage.write(key: _kAccess, value: accessToken);
    if (refreshToken != null) {
      await _storage.write(key: _kRefresh, value: refreshToken);
    }
    await _storage.write(key: _kUser, value: jsonEncode(user.toJson()));
  }

  @override
  Future<void> clearSession() async {
    await _storage.delete(key: _kAccess);
    await _storage.delete(key: _kRefresh);
    await _storage.delete(key: _kUser);
    await clearPatientLinkedAccounts();
  }

  @override
  Future<void> persistPatientLinkedAccounts({
    required List<int> userIds,
    required int activeUserId,
  }) async {
    await _storage.write(key: _kPatientUserIds, value: jsonEncode(userIds));
    await _storage.write(key: _kActivePatientUserId, value: activeUserId.toString());
  }

  @override
  Future<({List<int> userIds, int activeUserId})?> readPatientLinkedAccounts() async {
    final rawIds = await _storage.read(key: _kPatientUserIds);
    final rawActive = await _storage.read(key: _kActivePatientUserId);
    if (rawIds == null || rawIds.isEmpty || rawActive == null || rawActive.isEmpty) {
      return null;
    }
    try {
      final decoded = jsonDecode(rawIds);
      if (decoded is! List<dynamic>) {
        return null;
      }
      final ids = <int>[];
      for (final e in decoded) {
        if (e is int) {
          ids.add(e);
        } else if (e is num) {
          ids.add(e.toInt());
        }
      }
      final active = int.tryParse(rawActive);
      if (active == null || ids.isEmpty) {
        return null;
      }
      return (userIds: ids, activeUserId: active);
    } on Object {
      return null;
    }
  }

  @override
  Future<void> clearPatientLinkedAccounts() async {
    await _storage.delete(key: _kPatientUserIds);
    await _storage.delete(key: _kActivePatientUserId);
  }
}
