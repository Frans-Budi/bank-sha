import 'package:bank_sha/blocs/transfer/transfer_bloc.dart';
import 'package:bank_sha/models/transfer_form_model.dart';
import 'package:bank_sha/shared/methods.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../blocs/auth/auth_bloc.dart';

class TransferAmountScreen extends StatefulWidget {
  final TransferFormModel data;

  const TransferAmountScreen({
    super.key,
    required this.data,
  });

  @override
  State<TransferAmountScreen> createState() => _TransferAmountScreenState();
}

class _TransferAmountScreenState extends State<TransferAmountScreen> {
  final TextEditingController amountController =
      TextEditingController(text: '0');

  @override
  void initState() {
    super.initState();

    amountController.addListener(() {
      final text = amountController.text;

      amountController.value = amountController.value.copyWith(
        text: NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: '')
            .format(int.parse(text == '' ? '0' : text.replaceAll('.', ''))),
      );
    });
  }

  void addAmount(String number) {
    if (amountController.text == '0') {
      amountController.text = '';
    }
    setState(() {
      amountController.text = amountController.text + number;
    });
  }

  deleteAmount() {
    if (amountController.text.isNotEmpty) {
      setState(() {
        amountController.text = amountController.text
            .substring(0, amountController.text.length - 1);

        if (amountController.text == '') {
          amountController.text = '0';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackgroundColor,
      body: BlocProvider(
        create: (context) => TransferBloc(),
        child: BlocConsumer<TransferBloc, TransferState>(
          listener: (context, state) {
            if (state is TransferFailed) {
              showCustomSnackbar(context, state.e);
            }

            if (state is TransferSuccess) {
              context.read<AuthBloc>().add(
                    AuthUpdateBalance(
                      int.parse(amountController.text.replaceAll('.', '')) * -1,
                    ),
                  );

              Navigator.pushNamedAndRemoveUntil(
                  context, '/transfer-success', (route) => false);
            }
          },
          builder: (context, state) {
            if (state is TransferLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 58),
              children: [
                const SizedBox(height: 65),
                // Title
                Center(
                  child: Text(
                    "Total Amount",
                    style: AppTheme.whiteTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: AppTheme.semiBold,
                    ),
                  ),
                ),
                const SizedBox(height: 65),
                // Input Amount
                Align(
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      controller: amountController,
                      enabled: false,
                      cursorColor: AppTheme.greyColor,
                      style: AppTheme.whiteTextStyle.copyWith(
                        fontSize: 36,
                        fontWeight: AppTheme.medium,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Text(
                          "Rp ",
                          style: AppTheme.whiteTextStyle.copyWith(
                            fontSize: 36,
                            fontWeight: AppTheme.medium,
                          ),
                        ),
                        disabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppTheme.greyColor),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppTheme.greyColor),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 66),
                // Button PIN
                Wrap(
                  spacing: 40,
                  runSpacing: 40,
                  alignment: WrapAlignment.end,
                  children: [
                    CustomInputButton(
                      title: "1",
                      onTap: () => addAmount('1'),
                    ),
                    CustomInputButton(
                      title: "2",
                      onTap: () => addAmount('2'),
                    ),
                    CustomInputButton(
                      title: "3",
                      onTap: () => addAmount('3'),
                    ),
                    CustomInputButton(
                      title: "4",
                      onTap: () => addAmount('4'),
                    ),
                    CustomInputButton(
                      title: "5",
                      onTap: () => addAmount('5'),
                    ),
                    CustomInputButton(
                      title: "6",
                      onTap: () => addAmount('6'),
                    ),
                    CustomInputButton(
                      title: "7",
                      onTap: () => addAmount('7'),
                    ),
                    CustomInputButton(
                      title: "8",
                      onTap: () => addAmount('8'),
                    ),
                    CustomInputButton(
                      title: "9",
                      onTap: () => addAmount('9'),
                    ),
                    CustomInputButton(
                      title: "0",
                      onTap: () => addAmount('0'),
                    ),
                    GestureDetector(
                      onTap: () => deleteAmount(),
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.numberBackgroudColor,
                        ),
                        child: const Center(
                          child: Icon(Icons.arrow_back,
                              color: AppTheme.whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                CustomFilledButton(
                  title: "Continue",
                  onPressed: () async {
                    if (await Navigator.pushNamed(context, '/pin') == true) {
                      final authState = context.read<AuthBloc>().state;
                      String pin = '';
                      if (authState is AuthSuccess) {
                        pin = authState.user.pin!;
                      }

                      context.read<TransferBloc>().add(
                            TransferPost(
                              widget.data.copyWith(
                                pin: pin,
                                amount:
                                    amountController.text.replaceAll('.', ''),
                              ),
                            ),
                          );
                    }
                  },
                ),
                const SizedBox(height: 25),
                CustomTextButton(
                  title: "Terms & Conditions",
                  onPressed: () {},
                ),
                const SizedBox(height: 40),
              ],
            );
          },
        ),
      ),
    );
  }
}
