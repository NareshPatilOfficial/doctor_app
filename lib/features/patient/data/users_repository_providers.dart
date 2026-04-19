import 'package:doctorbridge_mobile_ui/core/network/dio_provider.dart';
import 'package:doctorbridge_mobile_ui/features/patient/data/users_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_repository_providers.g.dart';

@Riverpod(keepAlive: true)
UsersRepository usersRepository(Ref ref) {
  return UsersRepository(ref.watch(dioProvider));
}
