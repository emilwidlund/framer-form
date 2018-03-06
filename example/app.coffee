{Scene, Studio, Mesh, Model} = require '../form.coffee'

studio = new Studio
	width: Screen.width
	height: Screen.height

new Model
	path: './models/samba/samba.fbx'
	parent: studio
	reposition: false
	onLoad: (model) ->

		studio.animationLoop = () ->
			model.rotationY += .1