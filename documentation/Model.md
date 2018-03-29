## Model
A model is your 3D-object that you designed in your 3d-modelling software. It may include geometry, materials & animations.
The model class does not extend the Framer Layer class, compared to the Scene class.

_Important: If you're trying to import a model to a scene and you can't see anything being rendered, it's most likely because you have no lights in your scene. Add a light or apply `new MeshNormalMaterial` to the material-property to see your model. See example further down below. If that doesn't help, adjust the model scale-property as it might be too small or too big._

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
- `material` - <a href="https://threejs.org/docs/#api/materials/Material">Material</a> - Specifies the material to use. Read the documentation in the Material-link to see which properties that are supported. Default is the bundled material that comes with your model.


### Methods

#### .lookAt(Vector3) .lookAt(x, y, z)
Rotates the model to face the point in world space. Use this within the animationLoop to always face the position regardless of animations or similar.

#### .animate(Object)
Animates the model with the specified properties. Works like the usual Framer Animation API.

`options`
- `time` - Number - Animation length in seconds
- `delay` - Number - Animation delay in seconds
- `curve` - String - Animation Easing. This does only support the following strings:
  - `linear`
  - `easeInQuad`
  - `easeOutQuad`
  - `easeInOutQuad`
  - `easeInCubic`
  - `easeOutCubic`
  - `easeInOutCubic`
  - `easeInQuart`
  - `easeOutQuart`
  - `easeInOutQuart`
  - `easeInQuint`
  - `easeOutQuint`
  - `easeInOutQuint`
  - `easeInSine`
  - `easeOutSine`
  - `easeInOutSine`
  - `easeInExpo`
  - `easeOutExpo`
  - `easeInOutExpo`
  - `easeInCirc`
  - `easeOutCirc`
  - `easeInOutCirc`
  - `easeInElastic`
  - `easeOutElastic`
  - `easeInOutElastic`

#### Example: Make model visible in a scene without lights
A common usecase when you just want to import something and see what the model looks like without having to setup a lot of lights. This example applies a Normal-map to your model and doesn't interact with lights. More information about Normal-maps can be found <a href="https://en.wikipedia.org/wiki/Normal_mapping">here</a>.

```
scene = new Scene
  width: Screen.width
  height: Screen.height

new Model
  path: 'models/bike.fbx'
  parent: scene
  material: new MeshNormalMaterial
  onLoad: (model) ->
    
    scene.animationLoop = () ->
      model.rotationY += .1
```
