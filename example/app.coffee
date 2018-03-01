{Scene, Mesh, importModel} = require '../form.coffee'

scene = new Scene
	width: Screen.width
	height: Screen.height

m = new Mesh
	parent: scene
	geometry: new Form.BoxGeometry 1, 1, 1
	material: new Form.MeshNormalMaterial

m.on 'mouseover', ->
	console.log 'Mouse Over'

m.on 'mouseout', ->
	console.log 'Mouse Out'

m.on 'mousedown', ->
	console.log 'Mouse Down'

m.on 'mouseup', ->
	console.log 'Mouse Up'

scene.animationLoop = () ->
	for m, i in scene.scene.children
		m.rotation.x += (i + 1) / 100
		m.rotation.y += (i + 1) / 100