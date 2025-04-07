class EPricingCalculator {
  // Метод для розрахунку загальної ціни з урахуванням податку та доставки
  static double calculateTotalPrice(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    double shippingCost = getShippingCost(location);
    double totalPrice = productPrice + taxAmount + shippingCost;
    return totalPrice;
  }

  // Метод для розрахунку вартості доставки
  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  // Метод для розрахунку податку
  static String calculateTax(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  // Метод для отримання податкової ставки для конкретної локації
  static double getTaxRateForLocation(String location) {
    // Пошук податкової ставки для вказаної локації з бази даних або API.
    // Повернення відповідної податкової ставки.
    return 0.10; // Приклад податкової ставки 10%
  }

  // Метод для розрахунку вартості доставки
  static double getShippingCost(String location) {
    // Пошук вартості доставки для вказаної локації використовуючи API доставки.
    // Розрахунок вартості доставки на основі різних факторів як відстань, вага, тощо.
    return 5.00; // Приклад вартості доставки $5
  }

  /// -- Сума всіх значень кошика та повернення загальної суми
  // static double calculateCartTotal(CartModel cart) {
  //     return cart.items.map((e) => e.price).fold(0, (previousPrice, currentPrice) => previousPrice + (currentPrice ?? 0));
  // }
}
