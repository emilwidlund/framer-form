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

new Model
	path: './models/flamingo/flamingo.json'
	parent: scene
	scale: 1
	y: 80
	rotationY: -40
	material: new MeshPhongMaterial
		color: 0xffffff
		specular: 0xffffff
		shininess: 20
		morphTargets: true
		vertexColors: THREE.FaceColors
		flatShading: true
	onLoad: (model) ->

		model.states.test = 
			rotationY: 50
			options:
				time: 2
				curve: 'easeInOutQuart'
			
		model.animate 'test'

		scene.on Events.Pan, (e) ->
			model.rotationY += e.deltaX * .3