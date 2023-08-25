import 'dart:math';

import 'package:flutter/material.dart';

import '../sqlite_test/dog_db_helper.dart';
import '../sqlite_test/dog_model.dart';

List<Dog> dogs = [
  Dog(id:1, name: '푸들이'),
  Dog(id:2, name: '삽살이'),
  Dog(id:3, name: '말티말티'),
  Dog(id:4, name: '강돌이'),
  Dog(id:5, name: '진져'),
  Dog(id:6, name: '백구'),
];

class dogListPage extends StatelessWidget {

  const dogListPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: FutureBuilder(
          future: DBHelper().getAllDogs(),
          builder: (BuildContext context, AsyncSnapshot<List<Dog>> snapshot) {

            if(snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {

                  Dog? item= snapshot.data?[index] as Dog;
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      DBHelper().deleteDog(item.id);

                    },

                    child: Center(child: Text(item.name)),
                  );
                },
              );
            }
            else
            {
              return Center(child: CircularProgressIndicator(),);
            }
          },
        ),

        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(Icons.refresh),
              onPressed: () {
                print('click');
                DBHelper().deleteAlldogs();
              },
            ),
            SizedBox(height: 8.0),
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Dog dog = dogs[Random().nextInt(dogs.length)];
                DBHelper().createData(dog);
              },
            ),
          ],
        )

    );
  }
}
final _textController = TextEditingController();