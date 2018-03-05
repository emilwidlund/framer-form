{Scene} = require './Scene.coffee'

class exports.Studio extends Scene
    constructor: (properties={}) ->
        super properties

        @scene.background = new THREE.Color 0xa0a0a0

        @floor = new THREE.Mesh( new THREE.PlaneGeometry( 2000, 2000 ), new THREE.MeshPhongMaterial( { color: 0x999999, depthWrite: false } ) );
        @floor.rotation.x = -Math.PI / 2
        @floor.position.y = -15
        @floor.receiveShadow = true
        @scene.add @floor

        @grid = new THREE.GridHelper 2000, 20, 0x000000, 0x000000
        @grid.position.y = -20
        @grid.material.opacity = 0.2;
        @grid.material.transparent = true;
        @scene.add @grid

        
        @hlight = new THREE.HemisphereLight 0xffffff, 0x444444
        @hlight.position.set 0, 200, 0
        @scene.add @hlight

        @light = new Form.PointLight
        @light.position.y = 50
        @light.position.z = 50
        @light.castShadow = true
        @light.shadowMapWidth = 2048
        @light.shadowMapHeight = 2048
        @light.shadowBias = 0.0001

        @scene.add @light