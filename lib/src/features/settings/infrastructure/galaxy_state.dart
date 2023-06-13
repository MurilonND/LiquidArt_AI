part of 'galaxy_cubit.dart';

class GalaxyState extends Equatable {
  final String hostname;
  final int port;
  final String ipAddress;
  final String password;
  final SSHClient? client;
  final bool showErrors;
  final bool loading;

  const GalaxyState({
    this.hostname = 'lg',
    this.port = 22,
    this.ipAddress = '172.16.52.15',
    this.password = 'lq',
    this.client,
    this.showErrors = false,
    this.loading = false,
  });

  bool get formIsValid => ipAddress.isNotEmpty && password.isNotEmpty;

  @override
  List<Object?> get props =>
      [hostname, port, ipAddress, password, client, showErrors, loading];

  GalaxyState copyWith({
    String? hostname,
    int? port,
    String? ipAddress,
    String? password,
    SSHClient? client,
    bool? showErrors,
    bool? loading,
  }) {
    return GalaxyState(
      hostname: hostname ?? this.hostname,
      port: port ?? this.port,
      ipAddress: ipAddress ?? this.ipAddress,
      password: password ?? this.password,
      client: client ?? this.client,
      showErrors: showErrors ?? this.showErrors,
      loading: loading ?? this.loading,
    );
  }
}
