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
}

@Riverpod(keepAlive: true)
TokenStorage tokenStorage(Ref ref) => SecureTokenStorage(const FlutterSecureStorage());

class SecureTokenStorage implements TokenStorage {
  SecureTokenStorage(this._storage);

  final FlutterSecureStorage _storage;

  static const _kAccess = 'doctorbridge_access_token';
  static const _kRefresh = 'doctorbridge_refresh_token';
  static const _kUser = 'doctorbridge_user_json';

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
  }
}
