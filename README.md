# slick_for_flutter

A new Flutter package project.

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.


## Package

Slick for Flutter Provides 2 different things.

1. A class to help manage state in your application. This is built on top of provider.
2. A class to help design out flexible containers.


These are both in the alpha stage and are not ready for production. However they are fun to use for prototyping.



When using the Design Package:

You will need to create a ```UIState``` class, a ```UI``` class and a ```View``` class


Your ui state class will look something like this:
```dart
class _PageState extends UIState {

  int _count = 0;
  int get count => _count;

  void increase() {
    _count++;
    notifyListeners();
  }

  void decrease() {
    _count--;
    notifyListeners();
  }
}
```

Your UI class will look something like this:
```dart
class _Page extends UI<_PageState> with SizeAttactment, StyleAttachment {
  //you will have access to state.  
  get count => state.count;

  @override
  Widget build() {
    //Implement here
  }

}

```

## Using State

you can use the state directly, if you need access to the live state, place widget in the expose function.

eg method in class
```dart

Widget textCount(){
    return Text("$count");
}

```

eg using with expose

```dart
    Scaffold(
        body:expose(textCount)
    )
```

Whenever the state changes, expose will rebuild that particular section, while leaving the rest of the widget intact.


use the listen method for listening to ChangeNotifiers.




## Design

Design takes strong influence from tailwind.css

use the class as follows.


use tailwind classes here.
```dart
Design(
    style:"",
    children:[]
)
```


Support is limited to.
p,px,py, flex flex-grow-(number)
col, row, flex-col, flex-row

more to come.
