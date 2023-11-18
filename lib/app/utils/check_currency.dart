String? checkCurrency(String? currency) {
  switch (currency) {
    case 'ریال':
      return 'تومان';
    default:
      return currency;
  }
}
