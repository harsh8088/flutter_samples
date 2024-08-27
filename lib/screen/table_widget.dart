import 'package:flutter/material.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class TableWidget extends StatefulWidget {
  const TableWidget({super.key});

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
          key: scaffoldKey,
          body: TableView.builder(
            cellBuilder: (BuildContext context, TableVicinity vicinity) {
              return TableViewCell(
                child: Center(
                  child: Text('Cell ${vicinity.column} : ${vicinity.row}'),
                ),
              );
            },
            columnCount: 10,
            columnBuilder: (int column) {
              return const TableSpan(
                extent: FixedTableSpanExtent(100),
                foregroundDecoration: TableSpanDecoration(
                  border: TableSpanBorder(
                    trailing: BorderSide(
                      color: Colors.black,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              );
            },
            rowCount: 10,
            rowBuilder: (int row) {
              return TableSpan(
                extent: const FixedTableSpanExtent(100),
                backgroundDecoration: TableSpanDecoration(
                  color: row.isEven ? Colors.blueAccent[100] : Colors.white,
                ),
              );
            },
          )),
    );
  }
}
