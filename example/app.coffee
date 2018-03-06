{Scene, Studio, Mesh, Model} = require '../form.coffee'

scene = new Scene
	width: Screen.width
	height: Screen.height

light = new THREE.PointLight
light.position.set 0, 100, 100
scene.scene.add light

new Model
	path: './models/samba/samba.fbx'
	parent: scene
	scale: .1
	onLoad: (model) ->