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