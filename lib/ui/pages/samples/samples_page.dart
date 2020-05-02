import 'package:flutter/material.dart';

import 'package:flutter_demo/common/mock/samples.dart';
import 'package:flutter_demo/ui/widgets/samples_item.dart';

class SamplesPage extends StatefulWidget {
  final String headerTitle;

  const SamplesPage({Key key, this.headerTitle}) : super(key: key);

  @override
  _SamplesPageState createState() => _SamplesPageState();
}

class _SamplesPageState extends State<SamplesPage> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> filteredSamples =
        samples.where((item) => !(item['hidden'] ?? false)).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.headerTitle ?? "Samples"),
      ),
      body: Container(
        margin: EdgeInsets.all(6),
        child: ListView.separated(
          itemCount: filteredSamples.length,
          itemBuilder: (context, index) => SamplesItem(
            title: filteredSamples[index]["title"],
            description: filteredSamples[index]["description"],
            navigation: (filteredSamples[index]["navigation"] as Function),
          ),
          separatorBuilder: (context, index) => Container(
            height: 10,
          ),
        ),
      ),
    );
  }
}
