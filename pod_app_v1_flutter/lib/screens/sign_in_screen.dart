import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../main.dart';
import '../src/design/factory_theme.dart';

/// 登入頁。登入成功後由 go_router 的 redirect（監聽
/// `client.auth.authInfoListenable`）自動導向主畫面。
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FactoryColors.ink,
      body: Stack(
        children: [
          const Positioned.fill(child: _LoginBackdrop()),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 430),
                  child: Column(
                    children: [
                      Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          color: FactoryColors.blue.withValues(alpha: .16),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: FactoryColors.blue.withValues(alpha: .45),
                          ),
                        ),
                        child: const Icon(
                          Icons.precision_manufacturing_rounded,
                          color: FactoryColors.blue,
                          size: 36,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Factory Command',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -.8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '智慧工廠 IoT 營運與設備管理平台',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: .6),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(26),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x55000000),
                              blurRadius: 30,
                              offset: Offset(0, 16),
                            ),
                          ],
                        ),
                        child: SignInWidget(
                          client: client,
                          // Navigate explicitly as well as relying on the
                          // router listenable. This avoids a lost notification
                          // during the auth widget's final state transition.
                          onAuthenticated: () => context.go('/dashboard'),
                          onError: (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('登入失敗：$error'),
                                backgroundColor: FactoryColors.red,
                                duration: const Duration(seconds: 5),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'SECURE EDGE  •  REAL-TIME  •  OTA READY',
                        style: TextStyle(
                          color: FactoryColors.blue,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginBackdrop extends StatelessWidget {
  const _LoginBackdrop();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF111827), Color(0xFF17233A), Color(0xFF0B1220)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: CustomPaint(painter: _GridPainter()),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = FactoryColors.blue.withValues(alpha: .055)
      ..strokeWidth = .7;
    for (double x = 0; x < size.width; x += 34) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 34) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
