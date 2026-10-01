import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../main.dart';
import '../screens/sign_in_screen.dart';
import 'features/alerts/alerts_screen.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/device_detail/device_detail_screen.dart';
import 'features/device_detail/command_history_screen.dart';
import 'features/device_form/device_form_screen.dart';
import 'features/device_profiles/device_profiles_screen.dart';
import 'features/feature_catalog/feature_catalog_screen.dart';
import 'features/ota/ota_screen.dart';
import 'features/operations/operations_screen.dart';
import 'features/production/production_center_screen.dart';
import 'features/provisioning/provisioning_screen.dart';
import 'features/provisioning/nordic_mesh_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/settings/access_management_screen.dart';
import 'features/site_detail/site_detail_screen.dart';
import 'features/sites/sites_screen.dart';
import 'features/work_orders/work_orders_screen.dart';
import 'widgets/app_shell.dart';

final router = GoRouter(
  initialLocation: '/dashboard',
  // 登入狀態變化時重新評估 redirect。
  refreshListenable: client.auth.authInfoListenable,
  redirect: (context, state) {
    final signedIn = client.auth.isAuthenticated;
    final atSignIn = state.matchedLocation == '/signin';
    if (!signedIn) return atSignIn ? null : '/signin';
    if (atSignIn) return '/dashboard';
    return null;
  },
  routes: [
    GoRoute(path: '/signin', builder: (context, state) => const SignInScreen()),
    // 底部導覽五分頁（docs/product/enterprise-iot-platform-spec.md）。
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(shell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const DashboardScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/alerts',
              builder: (context, state) => const AlertsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/operations',
              builder: (context, state) => const OperationsScreen(),
              routes: [
                GoRoute(
                  path: 'production',
                  builder: (context, state) => const ProductionCenterScreen(),
                ),
                GoRoute(
                  path: 'workorders',
                  builder: (context, state) => const WorkOrdersScreen(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/assets',
              builder: (context, state) => const SitesScreen(),
              routes: [
                GoRoute(
                  path: 'device-form',
                  builder: (context, state) {
                    final q = state.uri.queryParameters;
                    return DeviceFormScreen(
                      siteId: int.tryParse(q['siteId'] ?? ''),
                      deviceId: int.tryParse(q['deviceId'] ?? ''),
                      serial: q['serial'],
                    );
                  },
                ),
                GoRoute(
                  path: ':siteId',
                  builder: (context, state) => SiteDetailScreen(
                    siteId: int.parse(state.pathParameters['siteId']!),
                  ),
                  routes: [
                    GoRoute(
                      path: 'devices/:deviceId',
                      builder: (context, state) => DeviceDetailScreen(
                        siteId: int.parse(state.pathParameters['siteId']!),
                        deviceId: int.parse(
                          state.pathParameters['deviceId']!,
                        ),
                      ),
                      routes: [
                        GoRoute(
                          path: 'commands',
                          builder: (context, state) => CommandHistoryScreen(
                            deviceId: int.parse(
                              state.pathParameters['deviceId']!,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
              routes: [
                GoRoute(
                  path: 'access',
                  builder: (context, state) => const AccessManagementScreen(),
                ),
                GoRoute(
                  path: 'features',
                  builder: (context, state) => const FeatureCatalogScreen(),
                ),
                GoRoute(
                  path: 'device-profiles',
                  builder: (context, state) => const DeviceProfilesScreen(),
                ),
                GoRoute(
                  path: 'provisioning',
                  builder: (context, state) => const ProvisioningScreen(),
                  routes: [
                    GoRoute(
                      path: 'nordic-mesh',
                      builder: (context, state) => const NordicMeshScreen(),
                    ),
                  ],
                ),
                GoRoute(
                  path: 'ota',
                  builder: (context, state) => const OtaScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
