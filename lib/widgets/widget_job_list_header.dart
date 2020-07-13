import 'package:flutter/material.dart';

class JobListHeaderWidget extends StatelessWidget {
  const JobListHeaderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: const <Widget>[
          Expanded(
            // flex: 2,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Date',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Job',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Fee',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            // flex: 2,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Commission',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
