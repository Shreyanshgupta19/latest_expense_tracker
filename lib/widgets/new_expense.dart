
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_expense_tracker/models/expense.dart';
import 'package:my_expense_tracker/widgets/income.dart';


class NewExpense extends StatefulWidget {
  const NewExpense({
    super.key,
    required this.onAddExpense,
    required this.onAddIncomes,
  });

  final void Function(Expense expense) onAddExpense;
  final void Function(Income income) onAddIncomes;

  @override
  State<NewExpense> createState() {
    return _IncomeState();
  }
}

class _IncomeState extends State<NewExpense> {
  List<String> _selectedPaymentType = ['Wallet', 'Cash'];
  String? _selectedPaymentMode = 'Wallet'; // Change the type to String?

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory;

  void _showDialog(){
    if(Platform.isIOS){
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: const Text('Invalid input'),
            content: const Text('Please make sure a valid title, amount, date and category was entered..'),
            actions: [ TextButton( onPressed: (){Navigator.pop(ctx);}, child: const Text('Okay'), ), ],
          )
      );
    }
    else {
      showDialog(    // here showDialog is a built in function and AlertDialog is a built in dialog widgets and it has couple of parameters like title, content, actions.
          context: context,
          builder:
              (ctx) {
            return AlertDialog(
              title: const Text('Invalid input'),
              content: const Text(
                  'Please make sure a valid title, amount, date and category was entered..'),
              actions: [
                TextButton(
                  onPressed: () { Navigator.pop(ctx); },
                  child: const Text('Okay'),
                ),
              ],
            );
          }
      );
    }
  }
  void _submitExpenseData() {
    final enterAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enterAmount == null || enterAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedPaymentMode == null ||
        _selectedCategory == null) {
      _showDialog();
      return;
    } else {
    //  final onAddIncomes = widget.onAddIncomes; // Save a reference to onAddIncomes
      widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enterAmount,
        selectedPaymentType: [_selectedPaymentMode!],
        category: _selectedCategory!,
      ));
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) =>  Incomes(onAddIncome: widget.onAddIncomes)));
    }
  }



  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0077FF),
      body: SafeArea(


        child: Column(

          children: [

            //     IconButton(onPressed: (){Navigator.of(context).pop();}, icon: Icon(Icons.arrow_back,color: Colors.white,)),
            const Text('Expense',style: TextStyle(color: Colors.white,fontSize: 20),),



         const Spacer(flex: 1,),

            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How much?',
                      style: TextStyle(
                        color: Color(0xFFFBFBFB),
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    TextFormField(
                      controller: _amountController,
                      style: TextStyle(fontSize: 35.0, color: Colors.white),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: ' 0',
                        label: Text('Amount',style: TextStyle(color: Colors.white),),
                        // label: Text('₹',style: TextStyle(color: Colors.white),),
                        hintStyle: TextStyle(color: Colors.white),
                        prefixText: '\₹ ',
                      ),
                    ),
                    SizedBox(height: 15,),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          height: 500,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 10,),
                              Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black54, // Set the border color
                                    width: 1.0, // Set the border width
                                  ),
                                  borderRadius: BorderRadius.circular(21), // Set border radius
                                ),
                                child: DropdownButton(
                                  padding: EdgeInsets.only(left: 10),
                                  underline: Container(),
                                  isExpanded: true,
                                  hint: Text('Category',style: TextStyle(color: Colors.black54),),
                                  value: _selectedCategory, // with that, we ensure that the currently selected value will be shown on the screen instead of showing this empty dropdown as it was the case before
                                  items: Category.values.map(     // In Category here .values property gives a list with all the values that make up the enum // items now wants a list of dropdown menu item values // Now,values is a list of Enum values, a list of categories,therefore,and items wants a list of dropdown menu items. And we have to call map on this list to transform it from one type of value into another type of value. Now map wants a function which will be executed automatically by dart for every list item,And we will get the list item for which the function is currently executed as a input value automatically passed in by dart
                                          (category){  // so here it will be a single category since this function will be invoked for all the category items
                                        return DropdownMenuItem(  // And we want return our dropdown menu item here Now dropdown menu item in the end is a widget where we have to set the child parameter to another widget which simply defines what will be shown on the screen And here i will keep this simple and simply output a text widget here and the text value should be this category but category is of type category,so our Enum type here, and to convert this to a string that can be output with the text widget,we have to access the special name property that's made available by dart,along with a couple of other properties on all those Enum keys,all those Enum items.And name as a to uppercase method which convert all letters to capital letters
                                          value: category,   // here value parameter will we the value that will be stored internally for every dropdown item. it will not be visible to the user,it's this child that's visible to the user but it will be stored internally and it will be this value that we get here (  onChanged: (value){   ) in this on changed function,whenever the user selects one of these dropdown items and here the value is the category itself So the specific Enum item that is mapped to a specific dropdown menu item
                                          child: Text( category.name.toUpperCase() ),
                                        );
                                      }
                                  ).toList(),  // here ( Category.values.map ) we have an iterable here in a place where a list is expected,and therefore,then we should call to list on the result of map
                                  onChanged: (value){  // The onChanged Parameter as always, for these buttons must be set to a function that should be executed when the button is pressed Though, here,it really is a function that will get a value of type dynamics because the value that it will get here will simply be the value that has been selected from dropdown and it's of type dynamic because Flutter,right now,does not know which kind of items will display in this dropdown
                                    if (value == null){
                                      return;
                                    }
                                    else{
                                      setState(() {
                                        _selectedCategory = value;
                                      });
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                child: TextFormField(
                                  controller: _titleController,
                                  //  onChanged: _filterMeals,
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.name,
                                  autocorrect: true,
                                  enableSuggestions: true,
                                  decoration: InputDecoration(
                                    hintText: 'Description',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(21),
                                      borderSide: BorderSide(
                                        color: Colors.black54,
                                        width: 1,
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(21),
                                      borderSide: BorderSide(
                                        color: Colors.black54,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(21),
                                      borderSide: BorderSide(
                                        color: Colors.black54,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black54, // Set the border color
                                    width: 1.0, // Set the border width
                                  ),
                                  borderRadius: BorderRadius.circular(21), // Set border radius
                                ),
                                child: DropdownButton(
                                  underline: Container(),
                                  isExpanded: true,
                                  hint: Text('Category',style: TextStyle(color: Colors.black54),),
                                  padding: EdgeInsets.only(left: 10),
                                  value: _selectedPaymentMode, // with that, we ensure that the currently selected value will be shown on the screen instead of showing this empty dropdown as it was the case before
                                  items: _selectedPaymentType.map(     // In Category here .values property gives a list with all the values that make up the enum // items now wants a list of dropdown menu item values // Now,values is a list of Enum values, a list of categories,therefore,and items wants a list of dropdown menu items. And we have to call map on this list to transform it from one type of value into another type of value. Now map wants a function which will be executed automatically by dart for every list item,And we will get the list item for which the function is currently executed as a input value automatically passed in by dart
                                          (category){  // so here it will be a single category since this function will be invoked for all the category items
                                        return DropdownMenuItem(  // And we want return our dropdown menu item here Now dropdown menu item in the end is a widget where we have to set the child parameter to another widget which simply defines what will be shown on the screen And here i will keep this simple and simply output a text widget here and the text value should be this category but category is of type category,so our Enum type here, and to convert this to a string that can be output with the text widget,we have to access the special name property that's made available by dart,along with a couple of other properties on all those Enum keys,all those Enum items.And name as a to uppercase method which convert all letters to capital letters
                                          value: category,   // here value parameter will we the value that will be stored internally for every dropdown item. it will not be visible to the user,it's this child that's visible to the user but it will be stored internally and it will be this value that we get here (  onChanged: (value){   ) in this on changed function,whenever the user selects one of these dropdown items and here the value is the category itself So the specific Enum item that is mapped to a specific dropdown menu item
                                          child: Text( category.toUpperCase() ),
                                        );
                                      }
                                  ).toList(),  // here ( Category.values.map ) we have an iterable here in a place where a list is expected,and therefore,then we should call to list on the result of map
                                  onChanged: (value){  // The onChanged Parameter as always, for these buttons must be set to a function that should be executed when the button is pressed Though, here,it really is a function that will get a value of type dynamics because the value that it will get here will simply be the value that has been selected from dropdown and it's of type dynamic because Flutter,right now,does not know which kind of items will display in this dropdown
                                    if (value == null){
                                      return;
                                    }
                                    else{
                                      setState(() {
                                        _selectedPaymentMode = value;
                                      });
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: (){_submitExpenseData();},
                                  child: const Text('Continue',style: TextStyle(color: Colors.white,fontSize: 18,),),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Color(0xFF7E3DFF)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }


}