{
	Scene 
	Studio 
	Model 
	Mesh
	MeshPhongMaterial
	MeshNormalMaterial
} = require '../form.coffee'

scene = new Studio
	width: Screen.width
	height: Screen.height
	###
	camera:
		orbitControls: true
	###

m = new Mesh
	parent: scene
	geometry: new FORM.BoxGeometry 30, 30, 30
	material: new MeshPhongMaterial
	y: 50
	x: 200

m2 = new Mesh
	parent: scene
	geometry: new FORM.BoxGeometry 30, 30, 30
	material: new MeshPhongMaterial
	y: 50
	x: -200

new Model
	path: './models/flamingo/flamingo.json'
	parent: scene
	scale: 1
	material: new MeshPhongMaterial
		color: 0xffffff
		specular: 0xffffff
		shininess: 20
		morphTargets: true
		vertexColors: FORM.FaceColors
		flatShading: true
	onLoad: (model) ->

		model.animate
			rotationY: 90
			options:
				time: 2
				curve: 'easeInOutQuart'

		###
		scene.camera.controls.target = model.position
		scene.camera.controls.autoRotate = true
		scene.camera.controls.enableRotate = true

		scene.on Events.Pan, (e) ->
			model.rotationY += e.deltaX * 0.3
		###
		
		clock = new FORM.Clock

		scene.animationLoop = () ->
			model.y = Math.sin(clock.getElapsedTime()) * 20 + 110