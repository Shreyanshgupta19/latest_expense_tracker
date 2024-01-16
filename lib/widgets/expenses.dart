
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_expense_tracker/DynamicUi/DynamicFloatingActionButton.dart';
import 'package:my_expense_tracker/DynamicUi/DynamicGradientColor.dart';
import 'package:my_expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:my_expense_tracker/models/expense.dart';
import 'package:my_expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'chart/chart.dart';


class Expenses extends StatefulWidget {
  Expenses({super.key,});


  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  List<String> _selectedMonths = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  String _selectedMonth = 'January';
  List<String> categoryFilters = ['Today', 'Week', 'Month', 'Year',];
  bool _showList = true;

  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.Shopping,
      selectedPaymentType: [],

    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.Subscription,
      selectedPaymentType: [],
    ),
  ];
  final List<Income> _registeredIncomes = [
    Income(
      title: 'Flutter Course',
      amount: 0,
      date: DateTime.now(),
      category: Category.Shopping,
      selectedPaymentType: [],
    ),

  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(onAddExpense: _addExpense, onAddIncomes: _addIncome);
      },
    );
  }

  Future<void> _addExpense(Expense expense) async {
    setState(() {
      _registeredExpenses.add(expense);
    });

    // CollectionReference collRef = FirebaseFirestore.instance.collection('user');
    // CollectionReference collRef = FirebaseFirestore.instance.collection('${widget.userCredentials}');
    // await FirebaseFirestore.instance.collection('users').doc(widget.userCredentials('email')).set({
    //   'expense-title': expense.title,
    //   'expense-amount': expense.amount,
    //   'expense-date': expense.date,
    //   'expense-category': expense.category.toString(),
    //   'income-amount': expense.amount,
    // });
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    // Create a reference to the user's collection of expenses
    CollectionReference userExpensesRef = FirebaseFirestore.instance.collection('users/$userId/expenses');

    // Add the expense data to the user's expenses collection
    await userExpensesRef.add({
      'title': expense.title,
      'amount': expense.amount,
      'date': expense.date,
      'category': expense.category.toString(),
      'income-amount': _registeredIncomes.fold<double>(0, (sum, income) => sum + income.amount),
    });

    // ref.add({
    //   'expense-title': expense.title,
    //   'expense-amount': expense.amount,
    //   'expense-date': expense.date,
    //   'expense-category': expense.category.toString(),
    //   'income-amount': expense.amount,
    //
    // });
  }


    Future<void> _addIncome(Income income) async {
      setState(() {
        _registeredIncomes.add(income);
      });
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      CollectionReference userIncomesRef = FirebaseFirestore.instance.collection('users/$userId/incomes');

      await userIncomesRef.add({
        'title': income.title,
        'amount': income.amount,
        'date': income.date,
        'category': income.category.toString(),
        // Add any other fields you need
      });
    }



  @override
  void initState() {
    super.initState();
    // Load expenses and incomes for the current user when the widget is initialized
    _loadExpenses();
    _loadIncomes();
  }

  Future<void> _loadExpenses() async {
    try {
      // Get the UID of the currently authenticated user
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId != null) {
        // Create a reference to the user's collection of expenses
        CollectionReference userExpensesRef =
        FirebaseFirestore.instance.collection('users/$userId/expenses');

        // Get the documents in the user's expenses collection
        QuerySnapshot<Map<String, dynamic>> expensesSnapshot =
        await userExpensesRef.get() as QuerySnapshot<Map<String, dynamic>>;

        // Process the retrieved expenses
        List<Expense> loadedExpenses = expensesSnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data()!;
          // Create Expense objects from the retrieved data
          return Expense(
            title: data['title'],
            amount: data['amount'],
            date: (data['date'] as Timestamp).toDate(),
            category: Category.values
                .firstWhere((e) => e.toString() == data['category']),
            selectedPaymentType: [],
            // Add any other fields you stored
          );
        }).toList();

        // Update the state with the loaded expenses
        setState(() {
          _registeredExpenses.clear();
          _registeredExpenses.addAll(loadedExpenses);
        });
      }
    } catch (error) {
      print('Error loading expenses: $error');
    }
  }
  Future<void> _loadIncomes() async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId != null) {
        CollectionReference userIncomesRef =
        FirebaseFirestore.instance.collection('users/$userId/incomes');

        QuerySnapshot<Map<String, dynamic>> incomesSnapshot =
        await userIncomesRef.get() as QuerySnapshot<Map<String, dynamic>>;

        List<Income> loadedIncomes = incomesSnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data()!;
          return Income(
            title: data['title'],
            amount: data['amount'],
            date: (data['date'] as Timestamp).toDate(),
            category: Category.values.firstWhere((e) => e.toString() == data['category']),
            selectedPaymentType: [], // Add any other fields you stored
          );
        }).toList();


        setState(() {
          _registeredIncomes.clear();
          _registeredIncomes.addAll(loadedIncomes);
        });
      }
    } catch (error) {
      print('Error loading incomes: $error');
    }
  }


  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  int _selectedPageIndex = 0;

  void _onTapselectPageIndex(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  String _selectedCategory = 'Today';

  @override
  Widget build(BuildContext context) {
    var activePageTitle = 'Home';
    Widget mainContent = const Center(
      child: Text('No expenses found, Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      final totalAmount = _registeredExpenses.fold<double>(
        0,
            (previousValue, expense) => previousValue + expense.amount,
      );

      final totalIncome = _registeredIncomes.fold<double>(
        0,
            (previousValue, transaction) {
          if (transaction is Income) {
            return previousValue + transaction.amount;
          } else {
            return previousValue;
          }
        },
      );

      mainContent = SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                gradient: DynamicGradientColor(
                  Colors.yellow.shade200,
                  Colors.white,
                ).myGradientColors(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 16,
                          backgroundImage: AssetImage(
                            'assets/master-design/images/avatar-05-bg.png',
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.purple,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        DropdownButton(
                          borderRadius: BorderRadius.circular(20),
                          icon: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.purple,
                          ),
                          value: _selectedMonth,
                          items: _selectedMonths.map(
                                (month) {
                              return DropdownMenuItem(
                                value: month,
                                child: Text(month),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            } else {
                              setState(() {
                                _selectedMonth = value;
                              });
                            }
                          },
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications,
                            color: Colors.purple,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Account Balance',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      '₹' + totalIncome.toString(),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: EdgeInsets.all(16.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    child: Image.asset(
                                      'assets/master-design/images/group-222.png',
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        child: Text(
                                          'Income',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        child: Text(
                                          '₹' + totalIncome.toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: EdgeInsets.all(16.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    child: Image.asset(
                                      'assets/master-design/images/group-223.png',
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        child: Text(
                                          'Expenses',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        child: Text(
                                          '₹' + totalAmount.toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryFilters.length,
                itemBuilder: (context, index) {
                  String category = categoryFilters[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: _selectedCategory == category
                            ? Colors.yellow[200]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: _selectedCategory == category
                              ? Color.fromARGB(255, 195, 178, 9)
                              : Colors.black54,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Recent Transaction',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showList = !_showList;
                    });
                  },
                  child: Text(_showList ? 'Hide All' : 'See All'),
                )
              ],
            ),
            SizedBox(height: 10,),
            if (_showList)
              Container(
                height: 500,
                child: ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense),
              ),
          ],
        ),
      );
    }

    Widget activePage = mainContent;

    if (_selectedPageIndex == 2) {
      activePage = Chart(expenses: _registeredExpenses);
    }

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: activePage,
      floatingActionButton: Transform.scale(
        scale: 1,
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          onPressed: () {
            _openAddExpenseOverlay();
          },
          child: Icon(Icons.add, color: Colors.white,),
        ),
      ),
      floatingActionButtonLocation: CustomFloatingActionButtonLocation(210, 90),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _onTapselectPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('assets/component/images/magicons-glyph-user-interface-home-4ZS.png'),
              color: _selectedPageIndex == 0 ? Colors.purple : Colors.black26,
              width: 24,
              height: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('assets/core-visual/images/magicons-glyph-finance-transaction-g1J.png'),
              color: _selectedPageIndex == 1 ? Colors.purple : Colors.black26,
              width: 24,
              height: 24,
            ),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('assets/component/images/magicons-glyph-finance-pie-chart-QE8.png'),
              color: _selectedPageIndex == 2 ? Colors.purple : Colors.black26,
              width: 24,
              height: 24,
            ),
            label: 'Budget',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('assets/core-visual/images/magicons-glyph-user-interface-user.png'),
              color: _selectedPageIndex == 3 ? Colors.purple : Colors.black26,
              width: 24,
              height: 24,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
