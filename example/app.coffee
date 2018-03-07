{Scene, Studio, Mesh, Model} = require '../form.coffee'

scene = new Studio
	width: Screen.width
	height: Screen.height

new Model
	path: './models/character/Defeated.dae'
	parent: scene
	animation: 1
	reposition: false
	scale: 50
	onLoad: (model) ->

		scene.on Events.MouseMove, (e) ->
			model.rotationY = Utils.modulate e.clientX, [0, Screen.width], [-180, 180], true