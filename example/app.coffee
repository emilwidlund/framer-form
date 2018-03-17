{
	Scene 
	Studio 
	Model 
	Mesh
	MeshPhongMaterial
	MeshNormalMaterial
	Light
} = require '../form.coffee'

scene = new Studio
	width: Screen.width
	height: Screen.height
	camera:
		orbitControls: true
		autoRotate: true
		enableRotate: true


new Model
	path: './models/train/train.fbx'
	parent: scene
	scale: 20
	reposition: false
	rotationY: -40
	onLoad: (model) ->

		###
		scene.on Events.Pan, (e) ->
			model.rotationY += e.deltaX * .3
		###