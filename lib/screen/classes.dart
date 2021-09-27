class Admin {
  String name;
  String number;

  Admin({required this.name, required this.number});
}

class DeliveryBoy {
  String name;
  String number;

  DeliveryBoy({required this.name, required this.number});
}

class Society {
  final String d_id;
  String name;

  Society({
    required this.d_id,
    required this.name,
  });
}

class SUser {
  final String d_id;
  final String Name;
  final String Address;
  final String Phone;

  SUser(
      {required this.d_id,
      required this.Name,
      required this.Address,
      required this.Phone});
}

class Product {
  final String d_id;
  final String Name;
  final String Price;

  Product({required this.d_id, required this.Name, required this.Price});
}

class Order {
  final int index;
  final String O_Time;
  final String P_Name;
  final String P_Price;
  final double P_Quantity;
  final double O_Total;

  Order(this.index, this.O_Time, this.P_Name, this.P_Price, this.P_Quantity,
      this.O_Total);
}

class Payment {
  String date;

  String ruppee;

  bool paid;

  String number;

  Payment(this.date, this.ruppee, this.paid, this.number);
}

class Detail {
  final String date;
  final String product;
  final String price;
  final String months;

  Detail(this.date, this.product, this.price, this.months);
}
