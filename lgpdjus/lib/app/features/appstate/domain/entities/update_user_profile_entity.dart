class UpdateUserProfileEntity {
  final String? nickName;
  final String? email;
  final String? newPassword;
  final String? oldPassword;

  UpdateUserProfileEntity({
    this.nickName,
    this.email,
    this.newPassword,
    this.oldPassword,
  }) {
    if ((email != null || newPassword != null) &&
        (oldPassword?.isEmpty != false)) {
      throw ('Precisa da senha atual para alterar a senha ou email');
    }
  }
}
