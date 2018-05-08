{
	Scene 
	Studio 
	Model 
	Mesh
	MeshPhongMaterial
	MeshNormalMaterial
	Light
} = require '../form.coffee'

scene = new Scene
	width: Screen.width
	height: Screen.height


new Model
	path: './models/flamingo/flamingo.json'
	parent: scene
	rotationY: -40
	material: new MeshNormalMaterial
		morphTargets: true
		flatShading: true
	onLoad: (model) ->

		model.states =
			test: 
				x: 50
				rotationZ: 180
				z: 0
				rotationY: 0
			testX:
				x: 0
				rotationZ: 0
				z: 300
				rotationY: 84
		
		scene.onClick ->
			model.stateCycle()