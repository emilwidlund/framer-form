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
	camera:
		orbitControls: true

cubes = []

for i in [0..10]
	m = new Mesh
		parent: scene
		geometry: new FORM.BoxGeometry 15, 15, 15
		material: new MeshPhongMaterial
		y: 80
	
	cubes.push m


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

		scene.camera.controls.target = model.position
		scene.camera.controls.enableRotate = true

		###
		scene.on Events.Pan, (e) ->
			model.rotationY += e.deltaX * 0.3
		###
		
		clock = new FORM.Clock
		orbitRadius = 150

		scene.animationLoop = () ->
			model.y = Math.sin(clock.getElapsedTime()) * 20 + 120

			for c, i in cubes
				c.x = Math.cos(clock.getElapsedTime()) * orbitRadius * (i * .2)
				c.z = Math.sin(clock.getElapsedTime()) * orbitRadius * (i * .2)

				c.y = Math.sin(clock.getElapsedTime()) * 20 + 80