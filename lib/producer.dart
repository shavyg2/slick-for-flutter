library producer;

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
part 'producer/context-aware.dart';




abstract class UIState extends ChangeNotifier implements ContextAwareBuilder{
  BuildContext _context;
  BuildContext get context =>_context;

  static setContext(BuildContext context,UIState state){
      state._context = context;
  }
}

abstract class UI<T extends UIState> implements ContextAwareBuilder {
  T _state;
  T get state => _state;

  BuildContext _context;
  BuildContext get context => _context;

  static setContext(UI p, BuildContext context) {
    return p._context = context;
  }

  static setState<T extends UIState>(UI p, T state) {
    return p._state = state;
  }

  Widget build();

  Widget expose(Widget Function() child) {
    return Consumer<T>(
      builder: (context, value, _) {
        return child();
      },
    );
  }


  Widget listen<A>(Widget Function() child){
    return Consumer<A>(
      builder:(context,value,_){
        return child();
      }
    );
  }



  Widget show(Widget Function() child){
    return child();
  }


  Widget select<A>({A Function() select,Widget Function() expose}){
    return Selector<T,A>(selector: (context,t){
      return select();
    },
    builder: (context,_,__){
      return expose();
    },
    
    );
  }
}

Widget make<T extends UIState>(UI p, [T state]) {
  return state == null ? _Maker(p) : _StatefulMaker<T>(p, state);
}

class _Maker<T extends UIState> extends StatelessWidget {
  T get state => null;

  final UI<T> producer;
  _Maker(this.producer) {
    if (producer == null) {
      throw "Producer is null";
    }
  }

  @override
  Widget build(BuildContext context) {
    _executeProducer(context, producer);
    return producer.build();
  }

  void _executeProducer(BuildContext context, UI<T> producer) {
    UI.setContext(producer, context);
  }
}

class _StatefulMaker<T extends UIState> extends _Maker {
  @override
  T get state => _state;

  final T _state;
  _StatefulMaker(UI producer, this._state) : super(producer) {
    UI.setState(producer, _state);
  }

  @override
  Widget build(BuildContext context) {
    UIState.setContext(context, state);
    return ChangeNotifierProvider<T>(
      builder: (_) {
        return state;
      },
      child: super.build(context),
    );
  }

  

  @override
  bool operator ==(Object any) {
    return any is _StatefulMaker<T> && any._state == _state;
  }
}

abstract class ViewBase<T extends UIState> {
  UI<T> get ui;
  T get state;
}

abstract class View<T extends UIState> extends StatelessWidget
    implements ViewBase<T> {
  T get state => null;

  @override
  Widget build(BuildContext context) {
    return make<T>(ui, state);
  }
}
