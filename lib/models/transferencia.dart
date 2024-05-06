class Transferencia {
  final double accountValue;
  final int accountNumber;

  Transferencia(this.accountValue, this.accountNumber);

  @override
  String toString() {
    return 'Transferência{valor: $accountValue, numeroConta: $accountNumber}  ';
  }
}
