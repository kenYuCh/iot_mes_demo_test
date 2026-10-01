import 'package:flutter/material.dart';

class DestructiveCredentials {
  const DestructiveCredentials({required this.email, required this.password});

  final String email;
  final String password;
}

Future<DestructiveCredentials?> showDestructiveReauthDialog(
  BuildContext context, {
  required String resourceName,
}) {
  return showDialog<DestructiveCredentials>(
    context: context,
    barrierDismissible: false,
    builder: (context) => _DestructiveReauthDialog(
      resourceName: resourceName,
    ),
  );
}

class _DestructiveReauthDialog extends StatefulWidget {
  const _DestructiveReauthDialog({required this.resourceName});

  final String resourceName;

  @override
  State<_DestructiveReauthDialog> createState() =>
      _DestructiveReauthDialogState();
}

class _DestructiveReauthDialogState extends State<_DestructiveReauthDialog> {
  final _email = TextEditingController(text: 'dev@demo.local');
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (_email.text.trim().isEmpty || _password.text.isEmpty) return;
    Navigator.of(context).pop(
      DestructiveCredentials(
        email: _email.text.trim(),
        password: _password.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.lock_outline, color: Colors.red),
      title: const Text('再次驗證管理者'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('要永久刪除「${widget.resourceName}」，請輸入目前登入帳號密碼。'),
          const SizedBox(height: 16),
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.username],
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _password,
            obscureText: _obscure,
            autofocus: true,
            autofillHints: const [AutofillHints.password],
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              labelText: '密碼',
              suffixIcon: IconButton(
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: Icon(
                  _obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Colors.red),
          onPressed: _submit,
          child: const Text('驗證並刪除'),
        ),
      ],
    );
  }
}
