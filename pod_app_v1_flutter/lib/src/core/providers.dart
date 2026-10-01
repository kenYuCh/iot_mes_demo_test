import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../main.dart' show client;

/// 全 App 共用的 Serverpod Client。
/// Widget 不直接 import main.dart 的全域變數，一律透過本 Provider 取得。
final clientProvider = Provider<Client>((ref) => client);
