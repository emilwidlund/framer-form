### Good to know

Framer Form uses THREE.js for most of its internal functionality. If you're familiar with that library, it might be handy to know that `THREE` is included as a global variable when using the Form-module.

### Installation

Download this repository. Copy form.coffee and the form-folder to the modules-folder in your Framer Project.

_This will change for the Alpha-release. There will be a more convinent way to install this module._

### Importing submodules

There are 2 ways to import submodules into your Framer Prototype.

You can import the submodules individually like this:
```
{
  Scene 
  Studio 
  Model 
  Mesh
  MeshPhongMaterial
  MeshNormalMaterial
} = require 'form'
```

Or simply just assign a variable to the whole object like this:

```
FORM = require 'form'
```

### Quick Start

Let's import a simple FBX-model and make it rotate when we touch the screen.

```
{
  Studio
  Scene
  Light
  Model 
  MeshPhongMaterial
} = require 'form'

scene = new Scene
  width: Screen.width
  height: Screen.height

light = new Light
  parent: scene
  type: 'point'
  y: 400
  z: 300

new Model
  path: 'models/monster.fbx'
  parent: scene
  onLoad: (model) ->

    scene.on Events.Pan, (e) ->
      model.rotationY += e.deltaX * .3
```

##### So what is happening here?
- First we import our submodules that we will use.
- Then we define our scene.
- We add a Pointlight to our scene
- We create a Model and reference the path to our model. Make sure that you have the model located in the models-folder.
  - We add this model to the scene using the parent property
  - We then receive the model in the onLoad-callback, where the model is the argument
- When the model is loaded, we listen on Pan-events on the scene and take the delta-value to control the rotation on the model
