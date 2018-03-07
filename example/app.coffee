{Scene, Studio, Mesh, Model} = require '../form.coffee'

scene = new Scene
	width: Screen.width
	height: Screen.height

light = new THREE.PointLight
light.position.set 0, 100, 100
scene.scene.add light

new Model
	path: './models/fighter/F-15C_Eagle.dae'
	parent: scene
	scale: 3
	rotationY: 180
	onLoad: (model) ->

		scene.animationLoop = () ->
			model.rotationY += .2