// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// TODO: Put public facing types in this file.

library GridsterDart.base;

import 'dart:html' as html;
import 'dart:js';
import 'GridsterOptions.dart';

class GridsterDart {

  GridsterOptions gridsterOpts = new GridsterOptions();
  var             gridster = null;

  GridsterDart();
  GridsterDart.fromOptions(GridsterOptions this.gridsterOpts){
    print("[GridsterDart] Constructor");
  }

  void  load(){
    print("[GridsterDart] Loading...");
    var tmp = html.querySelector(".gridster ul");
    this.gridster = tmp.gridster().data('gridster');
    print("[GridsterDart] Loading completed");
  }

}
