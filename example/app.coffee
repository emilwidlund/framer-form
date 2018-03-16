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
		vertexColors: FORM.FaceColors
		flatShading: true
	onLoad: (model) ->

		model.animate
			rotationY: 40
			options:
				time: 1.5
				curve: 'easeInOutQuart'