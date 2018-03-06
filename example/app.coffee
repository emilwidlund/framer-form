{Scene, Studio, Mesh, Model} = require '../form.coffee'

studio = new Studio
	width: Screen.width
	height: Screen.height

new Model
	path: './models/samba/samba.fbx'
	parent: studio
	reposition: false
	scale: .1
	onLoad: (model) ->

		model.states.test =
			rotationX: 180
		
		console.log model.states

		studio.animationLoop = () ->
			model.rotationY += .1