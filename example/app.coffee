{Scene, Studio, Mesh, Model} = require '../form.coffee'

###
scene = new Scene
	width: Screen.width
	height: Screen.height
###

studio = new Studio
	width: Screen.width
	height: Screen.height

new Model
	path: './models/samba/samba.fbx'
	parent: studio
	scale: .2
	onLoad: (model) ->
	
		studio.animationLoop = () ->
			model.rotationY += 0.3