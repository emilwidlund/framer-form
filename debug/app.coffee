{
	Scene 
	Studio 
	Model 
	Mesh
	MeshPhongMaterial
	MeshNormalMaterial
	Light
	ParticleSystem
} = require '../form.coffee'

scene = new Scene
	width: Screen.width
	height: Screen.height
	camera:
		orbitControls: true
		enableRotate: true

ps = new ParticleSystem
	parent: scene
	color: 0xff4444
	particleNoiseTexture: './images/perlin-512.png'
	particleSpriteTexture: './images/particle2.png'


###

new Model
	path: './models/flamingo/flamingo.json'
	parent: scene
	rotationY: -40
	material: new MeshNormalMaterial
		morphTargets: true
		flatShading: true
	onLoad: (model) ->

		scene.animationLoop = () ->
			scene.camera.lookAt model.position

		scene.camera.states =
			first: 
				x: 100
				y: -100
				z: 300
				options:
					curve: 'easeInOutQuart'
			second: 
				x: 300
				y: -50
				z: -200
				options:
					curve: 'easeInOutQuart'
			third:
				x: -100
				y: 200
				z: -200
				options:
					curve: 'easeInOutQuart'
		
		scene.onClick ->
			scene.camera.stateCycle('first', 'second', 'third')

###