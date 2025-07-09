import 'package:flutter/material.dart';
import 'package:paint_app/screens/wallet_screen.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TextEditingController _amountController = TextEditingController();

  void _clearField() {
    _amountController.clear();
  }

  void _submitRequest() {
    final amount = _amountController.text.trim();
    if (amount.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an amount')),
      );
    } else {
      print('Requesting withdrawal: ₹$amount');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Withdrawal request for ₹$amount submitted')),
      );
    }
  }

  void _goToWallet() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const WalletScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB4E0FC), Color(0xFFFFFFFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Withdraw',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200),
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  '10,000',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Available Balance',
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 30),

                // Withdraw form box
              Text(
                        'Your withdrawal request is encrypted and secure.',
                        style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30,),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE0F2F1), Color(0xFFD1F2EB)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      const Text(
                        'You can withdraw up to your available balance.',
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      const Text('Amount Withdraw',style: TextStyle(fontSize: 20, color: Colors.black),),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter Amount to Withdraw',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text('Min: 15,000', style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),

                      const SizedBox(height: 30),

                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _clearField,
                              child: const Text('Clean',style: TextStyle(color: Colors.black),),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _submitRequest,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              child: const Text('Request',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                const Text("Need help?"),
                const Text(
                  "Contact support at support@birlaopus.com",
                  style: TextStyle(color: Colors.blueAccent),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Wallet Icon
          Positioned(
            top: 50,
            right: 20,
            child: InkWell(
              onTap: _goToWallet,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black26)],
                ),
                child: const Icon(Icons.wallet_giftcard_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
