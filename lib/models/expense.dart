import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';                     // here i simply describe which data structure an expense in this app should have So which kind of structure an expense should have
                                                     // here we have created a data model
final formatter = DateFormat.yMd();       // here DateFormat class is provided by intl package
                        // here yMd constructor function simply creates formatter object which we can then use to format dates So it's a utility object, we could say created with help of the DateFormat class and yMd() constructor function provided by the intl package
// And this yMd constructor function defines how the date will be formatted 'y = year , M = month, d = date'

const uuid = Uuid();
// here Uuid is a third party package and we call the constructor like this Uuid(); and here '.v4()' method is used to generate unique string id and we assign it with 'id'.

// enum variableName { name }
enum Category { food, travel, Subscription, Shopping }   // this value is not wrapped in '' or " " because it is not string values but nonetheless, this entire syntax here is recognized by dart and treats these values kind of like string values.
// enum is a keyword that allows us to create a custom type we could say, that could be named Category here, which simply is a combination of predefined allowed values. we define those defined values between {}.

const categoryIcons = {  // in map {key:value} // here we map custom Category's values to icons by using 'ClassName.value' syntax. and when we call for e.g. Category.food it already map its icon
  Category.food : Icons.lunch_dining, Category.travel : Icons.flight_takeoff, Category.Subscription : Icons.movie, Category.Shopping : Icons.work,
};
const categoryIconsContainerColors = {  // in map {key:value} // here we map custom Category's values to icons by using 'ClassName.value' syntax. and when we call for e.g. Category.food it already map its icon
  Category.food : Colors.red, Category.travel : Colors.blue, Category.Subscription : Colors.purple, Category.Shopping : Colors.yellow,
};
const categoryIconsColors = {
  Category.food : Color(0xFF8B0000),  // Dark Red
  Category.travel : Color(0xFF002080),  // Dark Blue
  Category.Subscription : Color(0xFF4B0082),  // Indigo
  Category.Shopping : Color(0xFFFFFF00),  // Yellow

};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.selectedPaymentType,
    required this.category,
    // required this.incomeAmount
    DateTime? date,
  })  : id = uuid.v4(),
        date = date ?? DateTime.now(); // Set to current date and time if date is null

  final String id;
  final String title;
  final double amount;
  final List<String> selectedPaymentType;
  final Category category;
  final DateTime date; // Make it non-nullable
 // final Income incomeAmount;

  String get formattedDate {
    final formatter = DateFormat.yMd();
    return formatter.format(date);
  }

  String get formattedTime {
    return DateFormat('h:mm a').format(date);
  }
}
class Income {
  Income({
    required this.title,
    required this.amount,
    required this.selectedPaymentType,
    required this.category,
    DateTime? date,
  })  : id = uuid.v4(),
        date = date ?? DateTime.now(); // Set to current date and time if date is null

  final String id;
  final String title;
  final double amount;
  final List<String> selectedPaymentType;
  final Category category;
  final DateTime date; // Make it non-nullable

  String get formattedDate {
    final formatter = DateFormat.yMd();
    return formatter.format(date);
  }

  String get formattedTime {
    return DateFormat('h:mm a').format(date);
  }
}


class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});  // default constructor
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)    // alternative(extra) constructor function
      : expenses = allExpenses.where(
          (expense){
            return expense.category == category;
          }
  ).toList();

  double get totalExpenses{   // properties: getter class
    double sum = 0;

    for(final expense in expenses){     // or  var i = 0; i < expenses.length; i++
      sum += expense.amount;    // or sum = sum + expense.amount;

    }
    return sum;
  }
}