import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/blocs/payement_method/payment_method_bloc.dart';
import 'package:bank_sha/models/payment_method_model.dart';
import 'package:bank_sha/models/topup_form_model.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/pages/topup_amount_screen.dart';
import 'package:bank_sha/ui/widgets/bank_item.dart';
import 'package:bank_sha/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopupScreen extends StatefulWidget {
  const TopupScreen({super.key});

  @override
  State<TopupScreen> createState() => _TopupScreenState();
}

class _TopupScreenState extends State<TopupScreen> {
  PaymentMethodModel? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Up"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 30),
          // Title
          Text(
            "Wallet",
            style: AppTheme.blackTextStyle
                .copyWith(fontSize: 16, fontWeight: AppTheme.semiBold),
          ),
          const SizedBox(height: 10),
          // Card Info
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return Row(
                  children: [
                    Image.asset(
                      "assets/img_wallet.png",
                      width: 80,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.user.cardNumber!.replaceAllMapped(
                              RegExp(r".{4}"), (match) => "${match.group(0)} "),
                          style: AppTheme.blackTextStyle.copyWith(
                              fontSize: 16, fontWeight: AppTheme.medium),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          "${state.user.name}",
                          style: AppTheme.greyTextStyle.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                );
              }

              return Container();
            },
          ),
          const SizedBox(height: 30),
          // Select Bank
          Text(
            "Select Bank",
            style: AppTheme.blackTextStyle
                .copyWith(fontSize: 16, fontWeight: AppTheme.semiBold),
          ),
          const SizedBox(height: 14),
          BlocProvider(
            create: (context) => PaymentMethodBloc()..add(PaymentMethodGet()),
            child: BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
              builder: (context, state) {
                if (state is PaymentMethodSuccess) {
                  return Column(
                      children: state.paymentMethods.map((paymentMethod) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPaymentMethod = paymentMethod;
                        });
                      },
                      child: BankItem(
                        paymentMethod: paymentMethod,
                        isSelected:
                            paymentMethod.id == selectedPaymentMethod?.id,
                      ),
                    );
                  }).toList());
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
      floatingActionButton: (selectedPaymentMethod != null)
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomFilledButton(
                title: "Continue",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopupAmountScreen(
                        data: TopupFormModel(
                            paymentMethodCode: selectedPaymentMethod!.code),
                      ),
                    ),
                  );
                },
              ),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
