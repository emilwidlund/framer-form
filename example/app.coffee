{Scene, Studio, Mesh, Model} = require '../form.coffee'

scene = new Studio
	width: Screen.width
	height: Screen.height

new Model
	path: './models/flamingo/flamingo.json'
	parent: scene
	scale: 1
	y: 120
	material: new THREE.MeshPhongMaterial( { color: 0xffffff, specular: 0xffffff, shininess: 20, morphTargets: true, vertexColors: THREE.FaceColors, flatShading: true } )
	onLoad: (model) ->

		scene.on Events.MouseMove, (e) ->
			model.rotationY = Utils.modulate e.clientX, [0, Screen.width], [-180, 180], true