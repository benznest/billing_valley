import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'dart:html' as html;
class HandCursor extends MouseRegion {

  // get a reference to the body element that we previously altered


  HandCursor({Widget child}) : super(
      onHover: (PointerHoverEvent evt) {
        var appContainer = html.document.getElementsByTagName('body')[0] as html.Element;
        appContainer.style.cursor='pointer';
        // you can use any of these:
        // 'help', 'wait', 'move', 'crosshair', 'text' or 'pointer'
        // more options/details here: http://www.javascripter.net/faq/stylesc.htm
      },
      onExit: (PointerExitEvent evt) {
        var appContainer = html.document.getElementsByTagName('body')[0] as html.Element;
        appContainer.style.cursor='default';
      },
      child: child
  );

}