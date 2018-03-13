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

m = new Mesh
	parent: scene
	geometry: new FORM.BoxGeometry 30, 30, 30
	material: new MeshPhongMaterial
	y: 100
	x: 120

m2 = new Mesh
	parent: scene
	geometry: new FORM.BoxGeometry 30, 30, 30
	material: new MeshPhongMaterial
	y: 100
	x: -120

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
			rotationZ: 180
			options:
				time: 1.5
				curve: 'easeInOutQuart'
				delay: 1
		
		Utils.delay 5, ->
			model.animate
				rotationZ: 360
				options:
					time: 1.5
					curve: 'easeInOutQuart'

		
		scene.camera.controls.target = model.position
		scene.camera.controls.autoRotate = true
		scene.camera.controls.enableRotate = true
		
		###
		scene.on Events.Pan, (e) ->
			model.rotationY += e.deltaX * 0.3
		###
		
		clock = new FORM.Clock

		scene.animationLoop = () ->
			model.y = Math.sin(clock.getElapsedTime()) * 20 + 140
			
			m.rotationZ += 1
			m.rotationY += 1

			m2.rotationZ -= 1
			m2.rotationY -= 1