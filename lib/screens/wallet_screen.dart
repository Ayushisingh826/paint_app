import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  final double availableBalance = 10000;

  final List<Map<String, dynamic>> transactions = const [
    {
      "title": "Interior Paint",
      "code": "944353",
      "amount": 5000,
      "isCredit": true
    },
    {"title": "Withdraw", "code": "944353", "amount": 5000, "isCredit": false},
    {
      "title": "Interior Paint",
      "code": "944353",
      "amount": 5000,
      "isCredit": true
    },
    {"title": "Withdraw", "code": "944353", "amount": 5000, "isCredit": false},
    {
      "title": "Interior Paint",
      "code": "944353",
      "amount": 5000,
      "isCredit": true
    },
    {
      "title": "Interior Paint",
      "code": "944353",
      "amount": 5000,
      "isCredit": true
    },
    {
      "title": "Interior Paint",
      "code": "944353",
      "amount": 5000,
      "isCredit": true
    },
    {
      "title": "Interior Paint",
      "code": "944353",
      "amount": 5000,
      "isCredit": true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB4E0FC), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top bar with back button
              SizedBox(
                height: 48,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, size: 20),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Transaction History",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Available balance
              Text(
                availableBalance.toStringAsFixed(0),
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Available Balance",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 16),

              // Transaction List
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: transactions.length,
                 separatorBuilder: (_, __) => SizedBox.shrink(),

                  itemBuilder: (context, index) {
                    final tx = transactions[index];
                    final isCredit = tx["isCredit"] as bool;

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 2),
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          "assets/images/paint.png",
                          height: 28,
                          width: 28,
                        ),
                      ),
                      title: Text(
                        tx["title"],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(tx["code"]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/images/coin.png",
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${isCredit ? "+" : "-"}${tx["amount"]}",
                            style: TextStyle(
                              color: isCredit ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
