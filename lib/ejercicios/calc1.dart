// Clase abstracta
abstract class Operacion {
  double suma(double a, double b);
  double resta(double a, double b);
  double multiplicacion(double a, double b);
}

// Clase derivada que implementa la clase abstracta
class Calculadora extends Operacion {
  @override
  double suma(double a, double b) => a + b;

  @override
  double resta(double a, double b) => a - b;

  @override
  double multiplicacion(double a, double b) => a * b;
}

// Ejemplo de uso
void main() {
  Calculadora calc = Calculadora();
  print('Suma: ${calc.suma(10, 5)}');
  print('Resta: ${calc.resta(10, 5)}');
  print('Multiplicación: ${calc.multiplicacion(10, 5)}');
}
