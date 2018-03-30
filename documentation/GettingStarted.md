### Good to know

Framer Form uses THREE.js for most of its internal functionality. If you're familiar with that library, it might be handy to know that `THREE` is included as a global variable when using the Form-module.

### Installation

<a href='https://open.framermodules.com/framer-form'>
    <img alt='Install with Framer Modules'
    src='https://www.framermodules.com/assets/badge@2x.png' width='160' height='40' />
</a>

Download this repository. Copy form.coffee and the form-folder to the modules-folder in your Framer Project.

### Importing submodules

There are 2 ways to import submodules into your Framer Prototype.

You can import the submodules individually like this:
```
{
  Scene
  Light
  Model
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
  Scene
  Light
  Model
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
      model.rotationY += e.deltaX
```

##### So what is happening here?
- First we import our submodules that we will use.
- Then we define our scene.
- We add a Pointlight to our scene
- We create a Model and reference the path to our model. Make sure that you have the model located in the models-folder.
  - We add this model to the scene using the parent property
  - We then receive the model in the onLoad-callback, where the model is the argument
- When the model is loaded, we listen on Pan-events on the scene and take the delta-value to control the rotation on the model
