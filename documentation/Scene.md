## Scene
The scene is responisble for rendering your 3D assets. It takes care of the animationLoop, camera, raycasting and much more.
Under the hood, the Scene is a regular Framer Layer.

```
new Scene
  width: Screen.width
  height: Screen.height
```

The scene layer supports all of the <a href="https://framer.com/docs/#layer.layer">default Framer Layer-properties</a>.

### Properties
- `camera` - Camera - The camera used within the scene
- `animationLoop` - Function - Give this property a function and it will be executed each frame.

#### Example: Updating using the Animation Loop
If you want to continuously update the rotationY or any other property on your model, you can use the animationLoop.

```
scene = new Scene
  width: Screen.width
  height: Screen.height

new Model
  path: 'models/bike.fbx'
  onLoad: (model) ->
    
    scene.animationLoop = () ->
      model.rotationY += .1
```

## Camera
The camera captures the scene and feeds data in to the renderer.
Internally it is a PerspectiveCamera with 35 in Field of View.

### Properties
- `x` - Number - Specifies the camera x position. Default is 0.
- `y` - Number - Specifies the camera y position. Default is 0.
- `z` - Number - Specifies the camera z position. Default is 500.
- `rotationX` - Number - Specifies the camera rotationX position. Default is 0.
- `rotationY` - Number - Specifies the camera rotationY position. Default is 0.
- `rotationZ` - Number - Specifies the camera rotationZ position. Default is 0.
- `fov` - Number - Specifies the Field of View. Default is 35.
- `near` - Number - Specifies the camera frustum near plane. Default is 0.1.
- `far` - Number - Specifies the camera frustum far plane. Default is 10000.
- `zoom` - Number - Specifies the camera zoom factor.
- `aspect` - Number - Specifies the camera aspect ratio. Default is `scene.width / scene.height`
- `orbitControls` - Bool - Specifies if camera should orbit around a target
#### If `orbitControls` is enabled
- `enablePan` - Bool - Enables Camera Touch Panning. Default is `false`
- `enableZoom` - Bool - Enables Camera Touch Zooming. Default is `false`
- `enableRotate` - Bool - Enables Camera Touch Rotating. Default is `false`
- `autoRotateSpeed` - Number - Specifies the auto rotation speed while orbiting. Default is 10
- `target` - Position - Specifies a position for the camera to orbit around. If you want to orbit around a model, make sure to specify `model.position`. Default is `null`
