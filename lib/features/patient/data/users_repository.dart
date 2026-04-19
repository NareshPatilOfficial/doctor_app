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
      return UserProfileDto.fromJson(data);
    } on DioException catch (e) {
      throw UsersRepositoryException(_messageOrDefault(e, 'Could not load profile'));
    }
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
