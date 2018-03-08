{Scene, Studio, Model} = require '../form.coffee'

scene = new Studio
	width: Screen.width
	height: Screen.height

new Model
	path: './models/flamingo/flamingo.json'
	parent: scene
	scale: 1
	rotationY: -40
	material: new THREE.MeshPhongMaterial( { color: 0xffffff, specular: 0xffffff, shininess: 20, morphTargets: true, vertexColors: THREE.FaceColors, flatShading: true } )
	onLoad: (model) ->
		
		clock = new THREE.Clock

		scene.on Events.Pan, (e) ->
			model.rotationY += e.deltaX * 0.3

		scene.animationLoop = () ->
			model.y = Math.sin(clock.getElapsedTime()) * 20 + 110