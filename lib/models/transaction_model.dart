import 'package:bank_sha/models/payment_method_model.dart';
import 'package:bank_sha/models/transaction_type_model.dart';

class TransactionModel {
  final int? id;
  final int? amount;
  final DateTime? createdAt;
  final PaymentMethodModel? paymentMethod;
  final TransactionTypeModel? transactionType;

  TransactionModel({
    this.id,
    this.amount,
    this.createdAt,
    this.paymentMethod,
    this.transactionType,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      amount: json['amount'],
      createdAt: DateTime.tryParse(json['created_at']),
      paymentMethod: json['paymentMethod'] == null
          ? null
          : PaymentMethodModel.fromJson(json['paymentMethod']),
      transactionType: json['transactionType'] == null
          ? null
          : TransactionTypeModel.fromJson(json['transactionType']),
    );
  }
}
