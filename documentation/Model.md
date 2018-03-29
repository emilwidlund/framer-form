## Model
A model is your 3D-object that you designed in your 3d-modelling software. It may include geometry, materials & animations.
The model class does not extend the Framer Layer class, compared to the Scene class.

```
new Model
  path: 'models/bike.fbx'
  parent: scene
  onLoad: (model) ->
    print 'My model was successfully loaded into the scene'
```

### Properties
- `x` - Number - Specifies the model x position. Default is 0.
- `y` - Number - Specifies the model y position. Default is 0.
- `z` - Number - Specifies the model z position. Default is 0.
- `position` - Vector3 - Get the model position.
- `reposition` - Bool - Specifies if Form should center your model in world space. This makes sure that your model is in the center of the scene. Default is `true`
- `rotation` - Vector3 - Get the model rotation.
- `rotationX` - Number - Specifies the model rotationX position. Default is 0.
- `rotationY` - Number - Specifies the model rotationY position. Default is 0.
- `rotationZ` - Number - Specifies the model rotationZ position. Default is 0.
- `scale` - Number - Specifies the model scale. Default is 1.
- `scaleX` - Number - Specifies the model scaleX. Default is 1.
- `scaleY` - Number - Specifies the model scaleY. Default is 1.
- `scaleZ` - Number - Specifies the model scaleZ. Default is 1.
- `parent` - Object - Specifies the model parent. Default is `null`
- `visible` - Bool - Specifies if the model should render or not. Default is `true`
- `animation` - Number - Specifies the model animation clip to play. Default is 1.
- `children` - Array - Get the child objects.
- `states` - Object - The model states.
- `size` - Object - Get the model size.

#### Example: Updating using the Animation Loop
If you want to continuously update the rotationY or any other property on your model, you can use the animationLoop.

```
scene = new Scene
  width: Screen.width
  height: Screen.height

new Model
  path: 'models/bike.fbx'
  parent: scene
  onLoad: (model) ->
    
    scene.animationLoop = () ->
      model.rotationY += .1
```
