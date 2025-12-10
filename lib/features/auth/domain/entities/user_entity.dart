import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String roleId;
  final String universityId;

  const UserEntity({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.roleId,
    required this.universityId,
  });

  @override
  List<Object?> get props => [
    id,
    username,
    firstName,
    lastName,
    roleId,
    universityId,
  ];
}
