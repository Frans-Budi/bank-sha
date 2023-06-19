import 'package:bank_sha/models/operator_card_model.dart';
import 'package:bank_sha/shared/methods.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/pages/data_package_screen.dart';
import 'package:bank_sha/ui/widgets/buttons.dart';
import 'package:bank_sha/ui/widgets/data_provider_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/operator_card/operator_card_bloc.dart';

class DataProviderScreen extends StatefulWidget {
  const DataProviderScreen({super.key});

  @override
  State<DataProviderScreen> createState() => _DataProviderScreenState();
}

class _DataProviderScreenState extends State<DataProviderScreen> {
  OperatorCardModel? selectedOperatorCard;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beli Data"),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(height: 30),
          // From Wallet
          Text(
            'From Wallet',
            style: AppTheme.blackTextStyle
                .copyWith(fontSize: 16, fontWeight: AppTheme.semiBold),
          ),
          const SizedBox(height: 10),
          // Card Info
          Row(
            children: [
              Image.asset(
                "assets/img_wallet.png",
                width: 80,
              ),
              const SizedBox(width: 16),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.user.cardNumber!.replaceAllMapped(
                            RegExp(r".{4}"),
                            (match) => "${match.group(0)} ",
                          ),
                          style: AppTheme.blackTextStyle.copyWith(
                              fontSize: 16, fontWeight: AppTheme.medium),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          "Balance: ${formatCurreny(state.user.balance ?? 0)}",
                          style: AppTheme.greyTextStyle.copyWith(fontSize: 12),
                        ),
                      ],
                    );
                  }

                  return Container();
                },
              ),
            ],
          ),
          const SizedBox(height: 40),
          // Select Provider
          Text(
            'Select Provider',
            style: AppTheme.blackTextStyle
                .copyWith(fontSize: 16, fontWeight: AppTheme.semiBold),
          ),
          const SizedBox(height: 14),
          BlocProvider(
            create: (context) => OperatorCardBloc()..add(OpertaorCardGet()),
            child: BlocBuilder<OperatorCardBloc, OperatorCardState>(
              builder: (context, state) {
                if (state is OperatorCardSuccess) {
                  return Column(
                    children: state.operatorCards.map((operatorCard) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedOperatorCard = operatorCard;
                          });
                        },
                        child: DataProviderItem(
                          operatorCard: operatorCard,
                          isSelected:
                              operatorCard.id == selectedOperatorCard?.id,
                        ),
                      );
                    }).toList(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: (selectedOperatorCard != null)
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomFilledButton(
                title: "Continue",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DataPackageScreen(
                        operatorCard: selectedOperatorCard!,
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
