{Scene, Mesh, Import} = require '../form.coffee'

scene = new Scene
	width: Screen.width
	height: Screen.height
###
mesh = new Mesh
	parent: scene
	geometry: new Form.BoxGeometry 1, 1, 1
	material: new Form.MeshNormalMaterial
		wireframe: true
###
Import {path: './models/skull.obj', parent: scene, material: new THREE.MeshNormalMaterial, scale: .002}, (model) ->

	model.on 'mouseover', ->
		console.log 'Mouse Over'

	model.on 'mouseout', ->
		console.log 'Mouse Out'

	model.on 'mousedown', ->
		console.log 'Mouse Down'

	model.on 'mouseup', ->
		console.log 'Mouse Up'

	scene.animationLoop = () ->
		model.rotation.x += .01
		model.rotation.y += .01