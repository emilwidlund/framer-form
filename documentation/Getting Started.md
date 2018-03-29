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
  Model 
  MeshPhongMaterial
} = require 'form'

scene = new Studio
  width: Screen.width
  height: Screen.height

new Model
  path: 'models/bike.fbx'
  parent: scene
  scale: 1
  y: 80
  rotationY: -40
  onLoad: (model) ->

    scene.on Events.Pan, (e) ->
      model.rotationY += e.deltaX * .3
```

##### So what is happening here?
- First we import our submodules that we will use.
- Then we define our scene. We use the "Studio"-scene that has a pretty backdrop and some lights preloaded in the scene
- We create a Model and reference the path to our bike. Make sure that you have the model located in the models-folder.
  - We add this model to the scene using the parent property
  - We set the scale to 1 (other models may be scaled differently so you will often have to play around with this value)
  - We set the vertical position to 80 and the Y-rotation to -40
  - We then receive the model in the onLoad-callback, where the model is the argument
- When the model is loaded, we listen on Pan-events on the scene and take the delta-value to control the rotation on the model
