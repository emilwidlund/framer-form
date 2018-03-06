{Scene, Studio, Mesh, Model} = require '../form.coffee'

studio = new Studio
	width: Screen.width
	height: Screen.height

new Model
	path: './models/samba/samba.fbx'
	parent: studio
	reposition: false
	animate: false
	onLoad: (model) ->

		model.states.test =
			scale: 5
			options:
				time: 3

		model.animate 'test'

		Utils.delay 5, ->
			model.animate 'default'