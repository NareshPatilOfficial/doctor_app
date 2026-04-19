import 'package:dio/dio.dart';

import 'package:doctorbridge_mobile_ui/features/patient/data/models/user_profile_dto.dart';

class UsersRepositoryException implements Exception {
  UsersRepositoryException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Authenticated API: `/api/v1/users` (list + by id).
class UsersRepository {
  UsersRepository(this._dio);

  final Dio _dio;

  static const _usersPath = '/api/v1/users';

  Future<UserProfileDto> getUser(int userId) async {
    try {
      final res = await _dio.get<Map<String, dynamic>>('$_usersPath/$userId');
      final data = res.data;
      if (data == null) {
        throw UsersRepositoryException('Empty profile response');
      }
      final Map<String, dynamic> normalized = _normalizeSingleUserPayload(data);
      try {
        return UserProfileDto.fromJson(normalized);
      } on Object {
        throw UsersRepositoryException('Could not parse profile response');
      }
    } on UsersRepositoryException {
      rethrow;
    } on DioException catch (e) {
      throw UsersRepositoryException(_messageOrDefault(e, 'Could not load profile'));
    }
  }

  /// Single-user GET may return the entity directly or wrapped (`data`, `user`, …).
  /// [id] may be a number, numeric string, or only `userId`.
  Map<String, dynamic> _normalizeSingleUserPayload(Map<String, dynamic> raw) {
    var map = Map<String, dynamic>.from(raw);
    if (!map.containsKey('id') || map['id'] == null) {
      final nested = map['data'] ?? map['user'] ?? map['result'] ?? map['payload'];
      if (nested is Map) {
        map = Map<String, dynamic>.from(nested);
      }
    }
    if ((!map.containsKey('id') || map['id'] == null) && map['userId'] != null) {
      final uid = map['userId'];
      if (uid is num) {
        map['id'] = uid.toInt();
      } else if (uid is String) {
        final p = int.tryParse(uid);
        if (p != null) {
          map['id'] = p;
        }
      }
    }
    final idVal = map['id'];
    if (idVal is String) {
      final parsed = int.tryParse(idVal);
      if (parsed != null) {
        map['id'] = parsed;
      }
    } else if (idVal is num) {
      map['id'] = idVal.toInt();
    }
    return map;
  }

  /// Query: `userIds=1,2,3&size=100`
  Future<List<UserProfileDto>> listUsersByIds(
    List<int> userIds, {
    int size = 100,
  }) async {
    if (userIds.isEmpty) {
      return [];
    }
    try {
      final res = await _dio.get<dynamic>(
        _usersPath,
        queryParameters: <String, dynamic>{
          'userIds': userIds.join(','),
          'size': size,
        },
      );
      return _parseUserList(res.data);
    } on DioException catch (e) {
      throw UsersRepositoryException(_messageOrDefault(e, 'Could not load users'));
    }
  }

  List<UserProfileDto> _parseUserList(Object? data) {
    if (data is List) {
      return data
          .map((e) => UserProfileDto.fromJson(Map<String, dynamic>.from(e as Map<dynamic, dynamic>)))
          .toList();
    }
    if (data is Map<String, dynamic>) {
      final list = data['content'] ?? data['data'] ?? data['users'] ?? data['items'];
      if (list is List) {
        return list
            .map((e) => UserProfileDto.fromJson(Map<String, dynamic>.from(e as Map<dynamic, dynamic>)))
            .toList();
      }
    }
    return [];
  }

  String _messageOrDefault(DioException e, String fallback) {
    final data = e.response?.data;
    if (data is Map && data['message'] is String) {
      final m = data['message'] as String;
      if (m.isNotEmpty) {
        return m;
      }
    }
    return fallback;
  }
}
