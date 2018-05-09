## Light
Lights are used to illuminate the scene. There are 6 types of lights supported in Framer Form:
- `Pointlight`
- `Directional Light`
- `Hemisphere Light`
- `Spotlight`
- `Ambient Light`
- `Rectangle Area Light`

```
new Light
  parent: scene
  type: 'point'
  y: 300
  z: 400
```

### Properties
- `type` - String - Specifies what type of light
  - `point`
  - `directional`
  - `hemisphere`
  - `spot`
  - `ambient`
  - `rectarea`
- `parent` - Object - Specifies the light parent. Usually a scene. Default is `null`
- `intensity` - Number - Specifies the light intensity. Default is 1.
- `x` - Number - Specifies the light x position. Default is 0.
- `y` - Number - Specifies the light y position. Default is 0.
- `z` - Number - Specifies the light z position. Default is 0.
- `position` - Vector3 - Get the light position.
- `rotationX` - Number - Specifies the light rotationX position. Default is 0.
- `rotationY` - Number - Specifies the light rotationY position. Default is 0.
- `rotationZ` - Number - Specifies the light rotationZ position. Default is 0.
- `rotation` - Vector3 - Get the light rotation.
- `visible` - Bool - Specifies if the light should render or not. Default is `true`
- `states` - Object - The light states.
- `light` - Light - Returns the native THREE.Light

#### Type-specific Properties

- `color` - <a href="https://threejs.org/docs/#api/math/Color">Color</a> - Specifies color of the light. Should be used with `new THREE.Color` syntax. Default is 0xffffff.
  - Pointlight
  - Directional Light
  - Ambient Light
  - Spotlight
  - Rectangle Area Light
- `angle` - Number - Maximum extent of the spotlight, in radians, from its direction. Should be no more than Math.PI/2. The default is `Math.PI/3`
  - Spotlight
- `castShadow` - Bool - Specifies if the light should cast shadows or not. Default is `true`
  - Spotlight
  - Pointlight
  - Directional Light
- `decay` - Number - The amount the light dims along the distance of the light. Default is 1. For physically correct lighting, set this to 2.
  - Pointlight
  - Spotlight
- `distance` - Number - The distance from the light where the intensity is 0. When set to 0, then the light never stops. Default is 0.
  - Pointlight
  - Spotlight
- `width` - Number - Specifies the surface-width of the light. Default is 10.
  - Rectangle Area Light
- `height` - Number - Specifies the surface-height of the light. Default is 10.
  - Rectangle Area Light
- `target` - Object - A target to cast light towards. This should be a model or similar. Default is `new Vector(0, 0, 0)`
  - Spotlight

TODO: Add documention to more properties

### Methods

#### .lookAt(Vector3) .lookAt(x, y, z)
Rotates the light to face the point in world space. Use this within the animationLoop to always face the position regardless of animations or similar.

#### .animate(Object) .animate(String)
Animates the light with the specified properties.
If the argument is a string instead of an object, Framer Form expects it to be a State-name. Exactly as the regular Framer Animation-API.

`options` - Object - If argument is an object, you may specify an options-object with following properties:
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

#### .stateCycle(StateName: String)
- Cycles between the specified states. The method takes unlimited amount of arguments.
- If no arguments are specified, this method will cycle through all available states.

#### .stateSwitch(StateName: String)
Instantly applies the specified state's properties.
