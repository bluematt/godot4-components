# <img src="../icons/visual_look_at_node.svg" width="48" height="48"> `VisualLookAtNode` component

Rotates a Node2D to "look" at another Node2D.

## How to use

1. Attach the `VisualLookAtNode` component to your scene.  It is recommended to add this as a child of the node to control.
2. Select the node to control in `node`.  You can skip this step if the parent is already the node to control.
3. Select the Node2D to follow in `target_node`.
4. Adjust the `smoothing` to your preferences if you want the rotation to be interpolated.

A `smoothing` value of `1.0` will result in instant rotation towards the target node.  Smaller values will make the rotation take longer.

