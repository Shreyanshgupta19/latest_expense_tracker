
import 'package:my_expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';


const categoryIcons = {
  Category.food: 'assets/core-visual/images/magicons-glyph-travel-restaurant.png',
  Category.travel: 'assets/core-visual/images/magicons-glyph-travel-car.png',
  Category.Subscription: 'assets/core-visual/images/magicons-glyph-finance-recurring-bill.png',
  Category.Shopping: 'assets/core-visual/images/magicons-glyph-finance-salary.png',
};

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({
    super.key,
    required this.expense,
  });

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: categoryIconsContainerColors[expense.category],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(
              categoryIcons[expense.category]!,
              color: categoryIconsColors[expense.category],
            ),
          ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(
              '${expense.category.name}', // output is Category.Shopping how can i remove 'Category.' from here
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 5,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: 100,
                child: Text(
                  expense.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
              ]),

          // add
          const Spacer(),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '-₹${expense.amount.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                Text(expense.formattedTime),
              ],
            ),
          ),

              ]),

          ],
        ),
      ),
    );
  }
}
