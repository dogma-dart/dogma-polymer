// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [ModelElement] mixin.
library dogma_polymer.model_element;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Mixin for creating a Polymer element that holds a [Model].
///
/// A [ModelElement] allows the data layer to be expressed as custom elements
/// through Polymer. It provides a common interface to get and set a [Model]
/// within an element. When the [model] is changed a [modelChangedEvent] is
/// triggered that can be listened and responded to.
///
///     void modelChanged(CustomEvent event) {
///       var model = event.target.model;
///
///       print('Model changed to ${model.id}');
///     }
///
///     main() async {
///       await initPolymer();
///
///       var element = new MyModelElement();
///       element.on[ModelElement.modelChangedEvent].listen(modelChanged);
///     }
///
/// The [ModelElement] uses events to notify rather than explicitly setting the
/// model of a view so that view can decide when to change to the new value.
/// The [modelChangedEvent] event is not triggered when the contents of the
/// model changes, that is the job of @reflectable when defining the model, but
/// rather when the model is replaced completely.
///
/// The [ModelElement] does not contain any functionality to query for a model
/// instead the value of [model] should be changed programmatically through
/// another element or through the application.
abstract class ModelElement<Model> {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// Event for when the model changed.
  static const String modelChangedEvent = 'model-changed';

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The model attached to the element.
  Model _model;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The model attached to the element.
  ///
  /// If the value of the model changes then the [modelChangedEvent] will be
  /// fired.
  Model get model => _model;
  set model(Model value) {
    if (_model != value) {
      _model = value;
      fire(modelChangedEvent);
    }
  }

  //---------------------------------------------------------------------
  // PolymerElement
  //---------------------------------------------------------------------

  void attached() {
    if (_model != null) {
      fire(modelChangedEvent);
    }
  }

  html.CustomEvent fire(String type,
                       {detail,
                        bool canBubble: true,
                        bool cancelable: true,
                        html.Node node});
}
