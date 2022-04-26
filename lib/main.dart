import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

enum Type { cat, dog }

/* when you create an abstract class and create some properties (variables) or functions, all the classes that extends your class have to implement them. */
/* abstract classes can contain costurctor howevery they can't cunstructed directly. they need to be cunstructed using their subclasses. if you define a constructor for abstract classes they are not act like mixins any more!
because mixin does not have any constructor. */
/* so if you define some functionality in your method, this method is not abstract any more, and it's just a normal function, however the class is still abstract class. (abstract == empty -> no logic). By default when
 you are creatimg a fully functional method in your abstract class (again: these methods are not abstract any more and normal classes are not forced to call them), you are not able to call these implementations in your
 normal classes, and if you wanna call them you shoud use "mustCallSuper" meta tag. Of course afteradding this meta tag you should call super.functionName() in your normal class too. */
abstract class CarRun {
  final Type type;
  const CarRun({required this.type});

  String get types {
    if (this is Cat) {
      return "cat";
    } else {
      return "other";
    }
  }

  @mustCallSuper
  void run() {
    "Running...".log();
  }
}

abstract class CanWalk {
  @mustCallSuper
  void walk() {
    "Walking...".log();
  }
}

abstract class CanJump {
  @mustCallSuper
  void jump() {
    "Jumping...".log();
  }
}

/* when you create a class that exxtends from abstract class or implements that abstract class you should call all the abstract methods too. */
/* differences between extends and with: "extends" inherit from that particular thing however with the "with" class can inherit from maximum one class. */
/* mixins are like abstract classes but they have no logics, they're like interfaces without implementation. */
/* inheritance tip: in these normal classes "this" means our normal classes and "super" means other classes that extends from. */
/* if our class does not change we use "immutable" tag upper the class. */
@immutable
class Cat extends CarRun {
  Cat(Type type) : super(type: type);

  // @override here is a meta tag and means this method comes from super class.
  @override
  void run() {
    super.run();
    "catRunning".log();
  }
}

@immutable
class Dog with CanJump, CanWalk {}

void tester() {
  final cat = Cat(Type.cat);
  cat.run();
  cat.type.log();
  final dog = Dog();
  dog
    ..walk()
    ..jump();
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    tester();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
    );
  }
}
