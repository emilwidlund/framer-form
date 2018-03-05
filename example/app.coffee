{Scene, Mesh, Model} = require '../form.coffee'

scene = new Scene
	width: Screen.width
	height: Screen.height

light = new Form.PointLight
light.position.y = 500
light.position.z = 500
scene.scene.add light

new Model
	path: './models/samba/samba.fbx'
	parent: scene
	scale: .2
	onLoad: (model) ->

		scene.animationLoop = () ->
			model.rotationY += 0.3