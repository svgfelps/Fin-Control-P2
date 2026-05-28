class Validators {
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) return 'O campo $fieldName é obrigatório.';
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'O e-mail é obrigatório.';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value.trim())) return 'Informe um e-mail válido.';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'A senha é obrigatória.';
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$');
    if (!regex.hasMatch(value)) return 'Use 8+ caracteres, maiúscula, minúscula, número e especial.';
    return null;
  }

  static String? validateConfirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) return 'Confirme sua senha.';
    if (value != originalPassword) return 'As senhas não coincidem.';
    return null;
  }

  static String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) return 'Informe um valor.';
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null || parsed < 0) return 'Informe um valor válido.';
    return null;
  }
}
