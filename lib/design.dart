library design;


import 'dart:math';
import 'package:flutter/material.dart';

const double P1 = 5;
const double P2 = 10;
const double P3 = 15;
const double P4 = 20;
const double P5 = 25;
const double P6 = 30;
const double P8 = 35;
const double P10 = 40;
const double P12 = 45;
const double P16 = 50;
const double P20 = 70;

final _allowed = _split("""
flex flex-row flex-col flex-wrap

px-1 px-2 px-3 px-4 px-5 px-6 px-8 px-10 px-12 px-16 px-20
p-1 p-2 p-3 p-4 p-5 p-6 p-8 p-10 p-12 p-16 p-20
py-1 py-2 py-3 py-4 py-5 py-6 py-8 py-10 py-12 py-16 py-20 


mx-1 mx-2 mx-3 mx-4 mx-5 mx-6 mx-8 mx-10 mx-12 mx-16 mx-20
m-1 m-2 m-3 m-4 m-5 m-6 m-8 m-10 m-12 m-16 m-20
my-1 my-2 my-3 my-4 my-5 my-6 my-8 my-10 my-12 my-16 my-20
mx-auto


justify-start justify-end justify-center justify-between
justify-around justify-even

align-start align-end align-center align-stretch

""");

List<String> _split(String style) {
  return style
      .split(" ")
      .map((x) => x.trim())
      .where(((x) => x.length > 0))
      .toList();
}

mixin StyleAttachment {
  Widget styleV<T, K>(
      {@required T Function() style,
      @required Widget Function(T, K) builder,
      K data}) {
    return builder(style(), data);
  }

  Widget style<T, K>(
      T Function() style, Widget Function(T, K) builder, K data) {
    return styleV(style: style, builder: builder, data: data);
  }
}

class Design extends StatelessWidget {
  final List<String> style;
  final Widget child;
  final List<Widget> children;


  Design._internal({this.style,this.child,this.children});

  factory Design({@required String style, Widget child, List<Widget> children}) {
    final classes = _split(style);
    return Design._internal(style: classes,child:child,children:children,);
  }

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return _buildChild();
    } else {
      return _buildChildren(children);
    }
  }

  bool _hasPadding() {
    return style.where((x) => RegExp(r'^p').hasMatch(x)).length > 0;
  }

  List<String> _getLimitedPadding() {
    var px = RegExp(r'px');
    var py = RegExp(r'py');
    var p = RegExp(r'p-');

    var adjusted = style
        .where((x) => px.hasMatch(x) || py.hasMatch(x)||p.hasMatch(x)).toList();

    var lastPx = adjusted.lastWhere((x)=>px.hasMatch(x),orElse: ()=>null);
    var lastPy = adjusted.lastWhere((x)=>py.hasMatch(x),orElse: ()=>null);
    var lastP = adjusted.lastWhere((x)=>p.hasMatch(x),orElse: ()=>null);

    var lastPxIndex = adjusted.toList().lastIndexOf(lastPx);
    var lastPyIndex = adjusted.toList().lastIndexOf(lastPy);
    var lastPIndex = adjusted.toList().lastIndexOf(lastP);

    if(max(max(lastPxIndex, lastPyIndex,),lastPIndex)==lastPIndex){
      return [adjusted.elementAt(lastPIndex)];
    }else{
      return adjusted.where((x)=>!p.hasMatch(x)).toList();
    }
  }

  String _getPadding() {
    return style.where((x) => RegExp(r'^p').hasMatch(x)).last;
  }

  bool _hasMargin() {
    return style.where((x) => RegExp(r'^m').hasMatch(x)).length > 0;
  }

  String _getMargin() {
    return style.where((x) => RegExp(r'^m').hasMatch(x)).last;
  }

  bool _hasFlex() {
    return style.where((x) => RegExp(r'^flex').hasMatch(x)).length > 0;
  }

  String _getFlex() {
    return style.where((x) => RegExp(r'^flex').hasMatch(x)).last;
  }

  bool _hasJustification() {
    return style.where((x) => RegExp(r'^justify').hasMatch(x)).length > 0;
  }

  String _getJustification() {
    return style.where((x) => RegExp(r'^justify').hasMatch(x)).last;
  }

  dynamic _makeJustification(String setting) {
    switch (setting) {
      case "justify-end":
        return MainAxisAlignment.end;
      case "justify-center":
        return MainAxisAlignment.center;
      case "justify-between":
        return MainAxisAlignment.spaceBetween;
      case "justify-around":
        return MainAxisAlignment.spaceEvenly;
      case "justify-even":
        return MainAxisAlignment.spaceEvenly;
      default:
        return MainAxisAlignment.start;
    }
  }

  bool _hasAlignment(){
    return style.where((x) => RegExp(r'^align').hasMatch(x)).length>0;
  }
  String _getAlignment() {
    return style.where((x) => RegExp(r'^align').hasMatch(x)).last;
  }

  dynamic _makeAlignment(String setting) {
    switch (setting) {
      case "align-stretch":
        return CrossAxisAlignment.stretch;
      case "align-end":
        return CrossAxisAlignment.end;
      case "align-center":
        return CrossAxisAlignment.center;
      default:
        return CrossAxisAlignment.start;
    }
  }

  dynamic _makeWrapJustification(String setting) {
    switch (setting) {
      case "justify-end":
        return WrapAlignment.end;
      case "justify-center":
        return WrapAlignment.center;
      case "justify-between":
        return WrapAlignment.spaceBetween;
      case "justify-around":
        return WrapAlignment.spaceEvenly;
      case "justify-even":
        return WrapAlignment.spaceEvenly;
      default:
        return WrapAlignment.start;
    }
  }



  Widget _addPadding(Widget child, String padding) {
    switch (padding) {
      //Horizontal Padding
      case "px-1":
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: P1), child: child);
      case "px-2":
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: P2), child: child);
      case "px-3":
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: P3), child: child);
      case "px-4":
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: P4), child: child);
      case "px-5":
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: P5), child: child);
      case "px-6":
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: P6), child: child);
      case "px-8":
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: P8), child: child);
      case "px-10":
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: P10), child: child);
      case "px-12":
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: P12), child: child);
      case "px-16":
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: P16), child: child);
      case "px-20":
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: P20), child: child);

      //Vertical Padding
      case "py-1":
        return Padding(
            padding: EdgeInsets.symmetric(vertical: P1), child: child);
      case "py-2":
        return Padding(
            padding: EdgeInsets.symmetric(vertical: P2), child: child);
      case "py-3":
        return Padding(
            padding: EdgeInsets.symmetric(vertical: P3), child: child);
      case "py-4":
        return Padding(
            padding: EdgeInsets.symmetric(vertical: P4), child: child);
      case "py-5":
        return Padding(
            padding: EdgeInsets.symmetric(vertical: P5), child: child);
      case "py-6":
        return Padding(
            padding: EdgeInsets.symmetric(vertical: P6), child: child);
      case "py-8":
        return Padding(
            padding: EdgeInsets.symmetric(vertical: P8), child: child);
      case "py-10":
        return Padding(
            padding: EdgeInsets.symmetric(vertical: P10), child: child);
      case "py-12":
        return Padding(
            padding: EdgeInsets.symmetric(vertical: P12), child: child);
      case "py-16":
        return Padding(
            padding: EdgeInsets.symmetric(vertical: P16), child: child);
      case "py-20":
        return Padding(
            padding: EdgeInsets.symmetric(vertical: P20), child: child);

      //All Padding
      case "p-1":
        return Padding(padding: EdgeInsets.all(P1), child: child);
      case "p-2":
        return Padding(padding: EdgeInsets.all(P2), child: child);
      case "p-3":
        return Padding(padding: EdgeInsets.all(P3), child: child);
      case "p-4":
        return Padding(padding: EdgeInsets.all(P4), child: child);
      case "p-5":
        return Padding(padding: EdgeInsets.all(P5), child: child);
      case "p-6":
        return Padding(padding: EdgeInsets.all(P6), child: child);
      case "p-8":
        return Padding(padding: EdgeInsets.all(P8), child: child);
      case "p-10":
        return Padding(padding: EdgeInsets.all(P10), child: child);
      case "p-12":
        return Padding(padding: EdgeInsets.all(P12), child: child);
      case "p-16":
        return Padding(padding: EdgeInsets.all(P16), child: child);
      case "p-20":
        return Padding(padding: EdgeInsets.all(P20), child: child);
      default:
        return child;
    }
  }

  bool _row() {
    return style.where((x) => RegExp(r'row$').hasMatch(x)).length > 0 ||
        style.contains("flex");
  }

  bool _col() {
    return style.where((x) => RegExp(r'col$').hasMatch(x)).length > 0;
  }

  bool _wrap() {
    return style.contains("flex-wrap");
  }

  Widget _buildChild() {
    return _buildChildren([child]);
  }

  Widget _buildChildren(List<Widget> children) {
    var content = [for (var child in children) _buildChildElement(child)];
    var container = _buildWrappingList(content);
    if (_hasPadding()) {
      _getLimitedPadding().forEach((padding){
        container = _addPadding(container, padding);
      });
    }

    return container;
  }

  Widget _buildWrappingList(List<Widget> content) {
    if (_wrap()) {
      if (_col()) {
        return Wrap(
          alignment: _hasAlignment()
              ? _makeWrapJustification(_getJustification())
              : _makeWrapJustification("justify-start"),
          direction: Axis.vertical,
          children: content,
        );
      } else {
        return Wrap(
          direction: Axis.horizontal,
          children: content,
        );
      }
    } else {
      //use regular row and col
      if (_col()) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: _hasJustification()
              ? _makeJustification(_getJustification())
              : _makeJustification("justify-start"),
          children: content,
        );
      } else {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: _hasJustification()
              ? _makeJustification(_getJustification())
              : _makeJustification("justify-start"),
          crossAxisAlignment: _hasAlignment()? _makeAlignment(_getAlignment()): _makeAlignment("align-start"),
          children: content,
        );
      }
    }
  }

  Widget _buildChildElement(Widget child) {
    if (_hasFlex()) {
      child = Expanded(flex: _getChildFlex(child), child: child);
    }
    return child;
  }

  int _getChildFlex(Widget child) {
    if (child is Design && child._flexGrow()) {
      int flexAmount = child._getFlexGrowValue();
      return flexAmount;
    } else {
      return 0;
    }
  }

  bool _flexGrow() {
    return style.where((x)=>RegExp(r'^flex-grow').hasMatch(x)).length>0;
  }

  int _getFlexGrowValue(){
    final numberFlex =style.where((x)=>RegExp(r'^flex-grow-\d+').hasMatch(x)).toList();
    if(numberFlex.length==0){
      return 1;
    }else{
      return int.parse(numberFlex.last.replaceRange(0, 10, ""));
    }
  }
}
