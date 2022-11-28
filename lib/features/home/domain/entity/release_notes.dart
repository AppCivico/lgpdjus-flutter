import 'package:equatable/equatable.dart';
import 'package:pub_semver/pub_semver.dart';

class ReleaseNote extends Equatable {
  ReleaseNote({
    required String version,
    required this.notes,
  }) : this.version = Version.parse(version);

  final Version version;
  final String notes;

  @override
  List<Object?> get props => [version, notes];
}
