// Clase base concreta
class Operacion {
  double suma(double a, double b) => a + b;
  double resta(double a, double b) => a - b;
  double multiplicacion(double a, double b) => a * b;
}

// Clase derivada que hereda los métodos
class Calculadora extends Operacion {
  // Puedes añadir nuevos métodos o sobreescribir si lo deseas
  double potencia(double base, double exponente) => base * exponente;
}

// Ejemplo de uso
void main() {
  Calculadora calc = Calculadora();
  print('Suma: ${calc.suma(8, 3)}');
  print('Resta: ${calc.resta(8, 3)}');
  print('Multiplicación: ${calc.multiplicacion(8, 3)}');
  print('Potencia: ${calc.potencia(8, 3)}');
}
