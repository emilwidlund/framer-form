# Framer Form

Framer Form is a <a href="https://framer.com" target="_blank">Framer</a>-module built with the purpose of exposing an extremely easy-to-use API for rendering 3D-graphics. Its purpose is not to reinvent and improve existing WebGL-rendering techniques, its purpose is rather to take existing techniques & libraries and expose them in the Framer Environment. It is built with common Framer-concepts like Animations, States & Events in mind.

### What can you expect from this module?

As most people probably want to import their own models & 3D-meshes to their Framer Prototype, Framer Form will have solid support for a wide array of different file formats. Import anything from FBX, 3DS & OBJ to JSON files, and have their respective materials applied with one simple line of code.

#### Currently Supported File Formats
- OBJ / MTL
- FBX
- GLTF / GLB
- COLLADA / DAE

#### File Formats to be added
- JSON
- 3DS
- SEA3D

### What does the syntax look like?

Framer Form aims to deliver an easy and familiar syntax for all its components. Framer Form has 2 fundamental components that you will interact with.

#### Scene
A Scene is a component that controls the 3D-environment. It handles Rendering, Cameras, Animation Loops, Raycasting and a bunch of other important concepts. But it is very easy to setup. The class itself extends the famous Framer Layer, which means that you could in theory animate & listen for common Framer Events on the scene. You can even specify "transparent" on the background-property in order to let all its geometry and meshes render with transparent background.

```
scene = new Scene
  width: Screen.width
  height: Screen.height
```

#### Model
A Model is a component that imports your 3D-model of choice. It applies associated materials, animation clips and other model-related concepts. As you can see below, the syntax is very familiar to other Framer classes. The code below imports an FBX-model with the name `bike.fbx`, applies the properties to the model and returns the model in the onLoad-callback. As soon as it is imported, we give the scene an animationLoop-function that will be called 60 times a second. In this specific function below, we tell the model to rotate around its Y-axis by .1 degrees each iteration.

```
new Model
  path: './models/bike.fbx'
  parent: scene
  x: 50
  y: 320
  rotationX: 180
  scale: 5
  onLoad: (model) ->
  
    scene.animationLoop = () ->
      model.rotationY += .1
```

### Where can I download the module and import it to my Framer Project?

This module is still under development and is not yet considered functional. An Alpha-release is expected to be released in Spring 2018. Hopefully in April.

### Built with

- Three.js
- Framer Library
- Inflate.js
- Underscore.js

### Contact

For any questions, highfives or concerns, please contact <a href="https://twitter.com/emilwidlund" target="_blank">me on Twitter</a>. If you found a bug, feel free to add an Issue to this repository and I'll take a look when I have time.
