{Scene, Studio, Model} = require 'form'

scene = new Studio
	size: Screen.size
	backgroundColor: 'transparent'

new Model
	path: 'models/monster.fbx'
	parent: scene
	rotationY: -40
	reposition: false
	scale: 1
	animation: 2
	onLoad: (model) ->
		
		scene.on Events.Pan, (e) ->
			model.rotationY += e.deltaX