import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int clunum=0;
  SharedPreferences? sharedPreferences;


  getAsyncData() async {
    // 获取实例
    sharedPreferences= await SharedPreferences.getInstance();
    // prefs= await SharedPreferences.getInstance();
    // // 获取存储数据
    // var count = prefs.getInt('count') ?? 0 + 1;
    // // 设置存储数据
    // await prefs.setInt('count', count);
    setState(() {
      sharedPreferences;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAsyncData();
  }
  @override
  Widget build(BuildContext context) {
    // getAsyncData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Table'),
      ),
      body:sharedPreferences==null?Text("请稍等"):Container(
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(columns: [
                DataColumn(label: Text('名')),
                DataColumn(label: Text('上把余额')),
                DataColumn(label: Text('输赢多少')),
                DataColumn(label: Text('剩余')),
              ], rows: _getCells())
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          clunum=sharedPreferences!.getInt("count")==null?0:sharedPreferences!.getInt("count")!;
          clunum++;
          sharedPreferences?.setInt("count", clunum);
          print("hjzcount==");
          print(sharedPreferences?.getInt("count"));
        }),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), //
    );
  }


  List<DataRow> _getCells() {
    String? name0=sharedPreferences!.getString("name${0}")==null?"小羊驼":sharedPreferences!.getString("name${0}");
    int? ups0=(sharedPreferences!.getInt("ups${0}"))!=null?sharedPreferences!.getInt("ups${0}"):0;
    int? points0=sharedPreferences!.getInt("points${0}")!=null?sharedPreferences!.getInt("points${0}"):0;
    int? down0=sharedPreferences!.getInt("down${0}")!=null?sharedPreferences!.getInt("down${0}"):0;
    String s0=ups0.toString();
    String s20=points0.toString();
    String s30=down0.toString();

    List<DataRow> cells = [DataRow(
      cells: [
        DataCell(TextField(controller: TextEditingController.fromValue(TextEditingValue(
            text: name0!
        )),onChanged: (value) {
          sharedPreferences?.setString("name${0}", value);
        })),
        DataCell(TextField(controller: TextEditingController.fromValue(TextEditingValue(
            text: s0
        )),onChanged: (value) {
          sharedPreferences!.setInt("ups${0}", int.parse(value));
        },)),
        DataCell(TextField(controller: TextEditingController.fromValue(TextEditingValue(
            text: s20
        )),onChanged: (value) {
          sharedPreferences!.setInt("points${0}", int.parse(value));
        })),
        DataCell(TextField(controller: TextEditingController.fromValue(TextEditingValue(
            text: s30
        )),onChanged: (value) {
          sharedPreferences!.setInt("down${0}", int.parse(value));
        })),
      ],
    )];

    if(sharedPreferences!=null){
      clunum=sharedPreferences!.getInt("count")==null?0:sharedPreferences!.getInt("count")!;
    }
    if(clunum==0){
      return cells;
    }
    for(int i=1;i<clunum;i++) {
      String? name=sharedPreferences!.getString("name${i}")==null?"":sharedPreferences!.getString("name${i}");
      int? ups=(sharedPreferences!.getInt("ups${i}"))!=null?sharedPreferences!.getInt("ups${i}"):0;
      int? points=sharedPreferences!.getInt("points${i}")!=null?sharedPreferences!.getInt("points${i}"):0;
      int? down=sharedPreferences!.getInt("down${i}")!=null?sharedPreferences!.getInt("down${i}"):0;
      String s1=ups.toString();
      String s2=points.toString();
      String s3=down.toString();
      print("hjz");
      print("name${i}");
      print(name);
      cells.add(DataRow(
        cells: [
          DataCell(TextField(onChanged: (value) {
            print("hjz");
            print("name${i}");
            sharedPreferences?.setString("name${i}", value);
            print(sharedPreferences!.getString("name${i}"));
          },controller: TextEditingController.fromValue(TextEditingValue(
              text: name!
          )))),
          DataCell(TextField(onChanged: (value) {
            print(value);
            sharedPreferences!.setInt("ups${i}", int.parse(value));
          },keyboardType: TextInputType.number,controller: TextEditingController.fromValue(TextEditingValue(
              text: s1
          )))),
          DataCell(TextField(onChanged: (value) {
            sharedPreferences!.setInt("points${i}", int.parse(value));
          },keyboardType: TextInputType.number,controller: TextEditingController.fromValue(TextEditingValue(
              text: s2
          )))),
          DataCell(TextField(onChanged: (value) {
            sharedPreferences!.setInt("down${i}", int.parse(value));
          },keyboardType: TextInputType.number,controller: TextEditingController.fromValue(TextEditingValue(
              text: s3
          )))),
        ],
      ));
    }
    return cells;
  }

// }
}
