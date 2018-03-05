{Scene, Mesh, Model} = require '../form.coffee'

scene = new Scene
	width: Screen.width
	height: Screen.height

light = new Form.PointLight
light.position.y = 500
light.position.z = 500
scene.scene.add light

new Model
	path: './models/helmet/DamagedHelmet.gltf'
	parent: scene
	scale: 1
	material: new THREE.MeshNormalMaterial
	onLoad: (model) ->

		scene.animationLoop = () ->
			model.rotationY += 0.3