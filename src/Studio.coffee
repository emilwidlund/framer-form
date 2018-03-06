{Scene} = require './Scene.coffee'

class exports.Studio extends Scene
    constructor: (properties={}) ->
        super properties

        @scene.background = new THREE.Color 0xa0a0a0
        @scene.fog = new THREE.Fog 0xa0a0a0, 200, 1000

        @camera.position.set 0, 220, 500
        @camera.rotation.x = THREE.Math.degToRad -15
        
        @hlight = new THREE.HemisphereLight 0xffffff, 0x444444
        @hlight.position.y = 200
        @scene.add @hlight

        @light = new THREE.DirectionalLight 0xffffff
        @light.position.set 70, 200, 100
        @light.castShadow = true
        @light.shadow.camera.top = 180
        @light.shadow.camera.bottom = -100
        @light.shadow.camera.left = -120
        @light.shadow.camera.right = 120
        @light.shadowMapWidth = 2048
        @light.shadowMapHeight = 2048
        @scene.add @light

        @floor = new THREE.Mesh( new THREE.PlaneGeometry( 2000, 2000 ), new THREE.MeshPhongMaterial( { color: 0x999999, depthWrite: false } ) );
        @floor.rotation.x = -Math.PI / 2
        @floor.receiveShadow = true
        @scene.add @floor

        @grid = new THREE.GridHelper 2000, 20, 0x000000, 0x000000
        @grid.material.opacity = .2
        @grid.material.transparent = true
        @scene.add @grid