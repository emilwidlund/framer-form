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


new Model
	path: './models/flamingo/flamingo.json'
	parent: scene
	y: 80
	rotationY: -40
	material: new MeshPhongMaterial
		color: 0xffffff
		specular: 0xffffff
		shininess: 20
		vertexColors: THREE.FaceColors
		morphTargets: true
		flatShading: true
	onLoad: (model) ->

		model.animate
			x: 100
			options: 
				time: 2.2
				delay: 2
				curve: 'easeInOutQuart'

		scene.on Events.Pan, (e) ->
			model.rotationY += e.deltaX * .3