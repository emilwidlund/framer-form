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

l = new Light
	parent: scene
	type: 'point'
	y: 300


new Model
	path: './models/flamingo/flamingo.json'
	parent: scene
	scale: 1
	rotationY: -40
	material: new MeshPhongMaterial
		color: 0xffffff
		specular: 0xffffff
		shininess: 20
		vertexColors: THREE.FaceColors
		morphTargets: true
		flatShading: true
	onLoad: (model) ->

		scene.on Events.Pan, (e) ->
			model.rotationY += e.deltaX * .3