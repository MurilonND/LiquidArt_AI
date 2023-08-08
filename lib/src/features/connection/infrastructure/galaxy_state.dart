part of 'galaxy_cubit.dart';

class GalaxyState extends Equatable {
  final String hostname;
  final int port;
  final String ipAddress;
  final String password;
  final SSHClient? client;
  final bool showErrors;
  final bool loading;
  final int lgScreens;
  final String? errorMessage;
  final String dalleKey;

  const GalaxyState({
    this.hostname = 'lg',
    this.port = 22,
    this.ipAddress = '172.16.51.173',
    this.password = 'lq',
    this.client,
    this.showErrors = false,
    this.loading = false,
    this.lgScreens = 3,
    this.errorMessage,
    this.dalleKey = ''
  });

  bool get formIsValid => ipAddress.isNotEmpty && password.isNotEmpty;

  @override
  List<Object?> get props => [
        hostname,
        port,
        ipAddress,
        password,
        client,
        showErrors,
        loading,
        lgScreens,
        errorMessage,
        dalleKey
      ];

  GalaxyState copyWith({
    String? hostname,
    int? port,
    String? ipAddress,
    String? password,
    SSHClient? client,
    bool? showErrors,
    bool? loading,
    int? lgScreens,
    String? errorMessage,
    String? dalleKey,
  }) {
    return GalaxyState(
      hostname: hostname ?? this.hostname,
      port: port ?? this.port,
      ipAddress: ipAddress ?? this.ipAddress,
      password: password ?? this.password,
      client: client ?? this.client,
      showErrors: showErrors ?? this.showErrors,
      loading: loading ?? this.loading,
      lgScreens: lgScreens ?? this.lgScreens,
      errorMessage: errorMessage ?? this.errorMessage,
      dalleKey: dalleKey ?? this.dalleKey,
    );
  }
}
