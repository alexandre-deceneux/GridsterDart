// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library GridsterDart.base;
import 'dart:js';
import 'GridsterOptions.dart';

class GridsterDart {

  var _gridsterOpts = null;
  var _gridster = null;

  GridsterDart();
  GridsterDart.fromOptions(GridsterOptions options){
    this._gridsterOpts = new JsObject.jsify(options.toJson());
  }

  void  setOptions(GridsterOptions options){
    this._gridsterOpts = new JsObject.jsify(options.toJson());
  }

  void  load([String boardSelector = "ul"]){
    var tmp = new JsObject(context["jQuery"], [".gridster $boardSelector"]);
    if (tmp == null)
      return;
    if (_gridsterOpts != null)
      _gridster = tmp.callMethod("gridster", [this._gridsterOpts])["data"];
    else
      _gridster = tmp.callMethod("gridster", [])["data"];
  }

}
