import 'package:doctorbridge_mobile_ui/core/auth/user.dart';
import 'package:doctorbridge_mobile_ui/features/patient/data/models/user_profile_dto.dart';

/// Merge login [base] with GET `/api/v1/users/{id}` — keeps auth [User.role] from login.
User mergeLoginUserWithProfile(User base, UserProfileDto profile) {
  final fromProfile = profile.displayName.trim();
  return User(
    id: profile.id.toString(),
    displayName: fromProfile.isNotEmpty ? fromProfile : base.displayName,
    role: base.role,
    email: profile.email,
    phone: profile.phone,
    firstName: profile.firstName,
    middleName: profile.middleName,
    lastName: profile.lastName,
    profilePicture: profile.profilePicture,
    gender: profile.gender,
  );
}

/// Session user when only profile DTO is available (restore / switch account).
User userFromProfileDto(UserProfileDto profile, {UserRole? roleOverride}) {
  final role = roleOverride ?? parseUserRole(profile.role ?? 'patient');
  return mergeLoginUserWithProfile(
    User(
      id: profile.id.toString(),
      displayName: profile.displayName,
      role: role,
    ),
    profile,
  );
}
