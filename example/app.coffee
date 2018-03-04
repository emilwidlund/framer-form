{Scene, Mesh, Model} = require '../form.coffee'

scene = new Scene
	width: Screen.width
	height: Screen.height

###
mesh = new Mesh
	parent: scene
	geometry: new Form.BoxGeometry 1, 1, 1
	material: new Form.MeshNormalMaterial
###

m = new Model
	path: './models/skull.obj'
	parent: scene
	material: new Form.MeshNormalMaterial
	scale: .01
	onLoad: (model) ->

		model.animate
			rotationY: 180
			options:
				time: 1

		scene.on Events.MouseMove, (e) ->
			model.rotation.y = THREE.Math.degToRad Utils.modulate(e.clientX, [0, Screen.width], [-30, 30], true)
			model.rotation.x = THREE.Math.degToRad Utils.modulate(e.clientY, [0, Screen.height], [-30, 30], true)

console.log m