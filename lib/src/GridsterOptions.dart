library GridsterDart.GridsterOptions;

/**
 * Defines option for the Gridster environnement
 */

class GWidgetMargins{
  int horizontal = 0;
  int vertical = 0;

  GWidgetMargins([int this.horizontal, int this.vertical]);

  toJson(){
    return [horizontal, vertical];
  }
}

class GWidgetPosition{
  int col = 0;
  int row = 0;

  GWidgetPosition([int this.col, int this.row]);
}

class GPixelSize{
  int width = 0;
  int height = 0;

  GPixelSize([int this.width, int this.height]);

  toJson(){
    return [width, height];
  }
}

class GGridCoords{
  GWidgetPosition position = new GWidgetPosition();
  GPixelSize      size = new GPixelSize();

  GGridCoords(GWidgetPosition this.position, GPixelSize this.size);
  GGridCoords.fromInts(int col, int row, int width, int height){
    this.position.col = col;
    this.position.row = row;
    this.size.width = width;
    this.size.height = height;
  }
}

class GDraggable{
  /**
   * A callback for when dragging starts.
   */
  GDraggableEvent start = (event, ui){};

  /**
   * A callback for when the mouse is moved during the dragging.
   */
  GDraggableEvent drag = (event, ui){};

  /**
   * A callback for when dragging stops.
   */
  GDraggableEvent stop = (event, ui){};

  toJson(){
    return {"start":start, "drag":drag, "stop":stop};
  }
}

class GResize{

  /**
   * Set to true to enable drag-and-drop widget resizing. This setting doesn't affect to the resize_widget method.
   */
  bool  enabled = false;

  /**
   * Axes in which widgets can be resized. Can be x, y or both
   */
  List<String> axes = ['both'];

  /**
   * CSS class name used by resize handles.
   */
  String handleClass = 'gs-resize-handle';

  /**
   * Set a valid CSS selector to append resize handles to. If value evaluates to false it's appended to the widget.
   */
  String handleAppendTo = '';

  /**
   * Limit widget dimensions when resizing. Array values should be integers: [max_cols_occupied, max_rows_occupied]
   */
  List<int> maxSize = [999999, 999999];

  /**
   * A callback executed when resizing starts.
   */
  GResizeEvent start = (event, ui, widget){};

  /**
   * A callback executed during the resizing.
   */
  GResizeEvent resize = (event, ui, widget){};

  /**
   * A callback executed when resizing stops.
   */
  GResizeEvent stop = (event, ui, widget){};

  toJson(){
    return {
      "enabled":enabled,
      "axes":axes,
      "handle_class":handleClass,
      "handle_append_to":handleAppendTo,
      "maxSize":maxSize,
      "start":start,
      "resize":resize,
      "stop":stop
    };
  }

}

class GCollision{

  /**
   * A callback for the first time when a widget enters a new grid cell.
   */
  GCollisionEvent onOverlapStart = (colliderData){};

  /**
   * A callback for each time a widget moves inside a grid cell.
   */
  GCollisionEvent onOverlap = (colliderData){};

  /**
   * A callback for the first time when a widget leaves its old grid cell.
   */
  GCollisionEvent onOverlapStop = (colliderData){};

  toJson(){
    return {
      "on_overlap_start":onOverlapStart,
      "on_overlap":onOverlap,
      "on_overlap_stop":onOverlapStop
    };
  }

}

typedef GSerializeParam(GGridCoords widget);
typedef GDraggableEvent(event, ui);
typedef GResizeEvent(event, ui, widget);
typedef GCollisionEvent(colliderData);

class GridsterOptions {

  /**
   * Define which elements are the widgets. Can be a CSS Selector string or a jQuery collection of HTMLElements.
   */
  String          widgetSelector = "li";

  /**
   * Horizontal and vertical margins respectively for widgets.
   */
  GWidgetMargins  widgetMargins = new GWidgetMargins(10, 10);

  /**
   * Base widget dimensions in pixels. The first index is the width, the second is the height.
   */
  GPixelSize      widgetBaseDimensions = new GPixelSize(400, 225);

  /**
   * Add more rows to the grid in addition to those that have been calculated.
   */
  int             extraRows = 0;

  /**
   * Add more rows to the grid in addition to those that have been calculated.
   */
  int             extraCols = 0;

  /**
   * The maximum number of columns to create. Set to `null` to disable.
   */
  int             maxCols = null;

  /**
   * The minimum number of columns to create.
   */
  int             minCols = 1;

  /**
   * The minimum number of rows to create.
   */
  int             minRows = 15;

  /**
   * The maximum number of columns that a widget can span.
   */
  int             maxSizeX = null;

  /**
   * If true, all the CSS required to position all widgets in their respective columns and rows will be generated
   * automatically and injected to the <head> of the document. You can set this to false and write your own CSS
   * targeting rows and cols via data-attributes like so: [data-col="1"] { left: 10px; }.
   */
  bool            autogenerateStylesheet = true;

  /**
   * Don't allow widgets loaded from the DOM to overlap. This is helpful if you're loading widget positions form
   * the database and they might be inconsistent.
   */
  bool            avoidOverlappedWidgets = true;

  /**
   *  function to return serialized data for each each widget, used when calling the serialize method.
   *  w: the grid coords object (GGridCoords) with keys col, row, size_x and size_y.
   */
  GSerializeParam serializeParams = (GGridCoords w){ return w; };

  /**
   * A callback for when dragging starts / is happening / stops.
   */
  GDraggable      draggable = new GDraggable();

  /**
   * Handle resize parameters and events
   */
  GResize         resize = new GResize();

  /**
   * Handle collision events
   */
  GCollision      collision = new GCollision();

  Map toJson(){
    var json = {
      "widget_selector":widgetSelector,
      "widget_margins":widgetMargins.toJson(),
      "widget_base_dimensions":widgetBaseDimensions.toJson(),
      "extra_rows":extraRows,
      "extra_cols":extraCols,
      "min_cols":minCols,
      "min_rows":minRows,
      "max_size_x":maxSizeX,
      "autogenerate_stylesheet":autogenerateStylesheet,
      "avoid_overlapped_widgets":avoidOverlappedWidgets,
      "serialize_params":serializeParams,
      "draggable":draggable.toJson(),
      "resize":resize.toJson(),
      "collision":collision.toJson()
    };
    if (maxCols != null)
      json["maxCols"] = maxCols;
    return json;
  }

}