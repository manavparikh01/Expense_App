import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import './widget/new_transaction.dart';
import './model/transaction.dart';
import './widget/transaction_list.dart';
import './widget/chart.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([
  //DeviceOrientation.portraitUp,
  //DeviceOrientation.portraitDown,
  //]);
  runApp(MyApp());
}

//class MyApp extends StatefulWidget {
//@override
//State<StatefulWidget> createState() {

//return MyApp();
//}
//}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp()
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Personal Expenses',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.amber,
              fontFamily: 'Quicksand',
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline5: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 18,
                    ),
                    button: TextStyle(
                      color: Colors.white,
                    ),
                  ),
              appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 20,
                      ),
                    ),
              ),
            ),
            home: MyHomePage(),
          );
  }
}

class MyHomePage extends StatefulWidget {
  //String titleInput;
  //String amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  //final titleController = TextEditingController();
  //final amountController = TextEditingController();

  final List<Transaction> _userTransactions = [
    //Transaction(
    //id: 'id1',
    //title: 'shoes',
    //amount: 300.00,
    //date: DateTime.now(),
    //),
    //Transaction(
    //id: 'id2',
    //title: 'jeans',
    //amount: 200.00,
    //date: DateTime.now(),
    //),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime choosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: choosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  bool _showChart = false;

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        }); //the widget we want to show inside the modal sheet
  }

  void _removeTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Widget> _isLandscapeBuild(AppBar appBar, Widget txList) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Show Chart',
            style: TextStyle(fontFamily: 'Quicksand'),
          ),
          Switch(
              activeColor: Theme.of(context).accentColor,
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
      _showChart
          ? Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: Chart(_recentTransactions),
            )
          : txList,
    ];
  }

  List<Widget> _isNotLandScapeBuild(AppBar appBar, Widget txList) {
    return [
      Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      txList
    ];
  }

  Widget _cupertinoAppBarBuilder() {
    return CupertinoNavigationBar(
      middle: Text('Personal Expenses'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //IconButton(
          //icon: Icon(
          //Icons.add,
          //),
          //onPressed: () => _startAddNewTransaction(context),
          //),
          GestureDetector(
              onTap: () => _startAddNewTransaction(context),
              child: Icon(CupertinoIcons.add))
        ],
      ),
    );
  }

  Widget _appBarBuilder() {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        'Personal Expenses',
        //style: TextStyle(fontFamily: 'Quicksand'),
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        //style: Theme.of(context).textTheme.headline6,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () => _startAddNewTransaction(context),
        ),
        //Icon(
        //Icons.ac_unit_rounded,
        //),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //final mediaQuery = MediaQuery.of(context);
    final _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final PreferredSizeWidget appBar =
        Platform.isIOS ? _cupertinoAppBarBuilder() : _appBarBuilder();
    final txList = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _removeTransaction),
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Container(
            //width: double.infinity,
            //child: Card(
            //color: Theme.of(context).accentColor,
            //color: Colors.blue,
            //child: Text(
            //'First chart',
            //style: TextStyle(fontFamily: 'Quicksand'),
            //),
            //elevation: 5,
            //),
            //),
            if (_isLandscape)
              ..._isLandscapeBuild(
                appBar,
                txList,
              ),
            if (!_isLandscape)
              ..._isNotLandScapeBuild(
                appBar,
                txList,
              ),
          ],
        ),
      ),
    );
    return MaterialApp(
      //debugShowCheckedModeBanner: true,
      //debugShowMaterialGrid: true,
      //debugShowCheckedModeBanner: false,
      home: Platform.isIOS
          ? CupertinoPageScaffold(
              child: pageBody,
            )
          : Scaffold(
              appBar: appBar,
              body: pageBody,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Platform.isIOS
                  ? Container()
                  : FloatingActionButton(
                      backgroundColor: Theme.of(context).accentColor,
                      child: Icon(
                        Icons.add,
                      ),
                      onPressed: () => _startAddNewTransaction(context),
                    ),
            ),
    );
  }
}
