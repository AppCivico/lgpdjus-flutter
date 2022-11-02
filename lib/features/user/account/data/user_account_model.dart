abstract class AccountModel {
  AccountModel({
    required this.email,
    required this.fullName,
    required this.nickname,
    required this.status,
  });

  final String? email;
  final String fullName;
  final String nickname;
  final String status;
}

class AccountLocalModel extends AccountModel {
  AccountLocalModel({
    required String? email,
    required String nickname,
    required String fullName,
    required String status,
  }) : super(
          email: email,
          fullName: fullName,
          nickname: nickname,
          status: status,
        );
}

class AccountRemoteModel extends AccountModel {
  AccountRemoteModel({
    required String? email,
    required String nickname,
    required String fullName,
    required String status,
  }) : super(
          email: email,
          fullName: fullName,
          nickname: nickname,
          status: status,
        );
}
