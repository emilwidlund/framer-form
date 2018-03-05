{Scene, Mesh, Model} = require '../form.coffee'

scene = new Scene
	width: Screen.width
	height: Screen.height

light = new Form.PointLight
light.position.y = 500
light.position.z = 500
scene.scene.add light

light2 = new Form.PointLight 0xffffff, .2
light2.position.y = -500
light2.position.z = 500
scene.scene.add light2

new Model
	path: './models/imperial.obj'
	parent: scene
	material: new Form.MeshStandardMaterial
	scale: .006
	onLoad: (model) ->

		scene.animationLoop = () ->
			if !scene.mousedown
				model.rotationY += .05
		
		scene.on 'mousemove', (e) ->
			if scene.mousedown
				model.rotationY = Utils.modulate e.clientX, [0, Screen.width], [-180, 180], true
				model.rotationX = Utils.modulate e.clientY, [0, Screen.height], [-180, 180], true