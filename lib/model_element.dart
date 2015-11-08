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

/// Mixin for creating a custom element that holds a [Model].
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
