bool isValidEmail(String correo) {
  // Utilizamos una expresión regular para verificar que el correo tenga un formato válido
  // Esta expresión regular es simple y verifica la presencia de un @ y un punto en el correo.
  // Puedes usar una expresión regular más sofisticada según tus necesidades.
  final RegExp regExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  return regExp.hasMatch(correo);
}