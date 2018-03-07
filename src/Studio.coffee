{Scene} = require './Scene.coffee'

class exports.Studio extends Scene
    constructor: (properties={}) ->
        super properties

        @scene.background = new THREE.Color 0x9191a0
        @scene.fog = new THREE.Fog 0x9191a0, 400, 1000

        @camera.position.set 0, 220, 500
        @camera.rotation.x = THREE.Math.degToRad -15
        
        @hlight = new THREE.HemisphereLight 0xffffff, 0x444444
        @hlight.position.y = 200
        @scene.add @hlight

        @light = new THREE.DirectionalLight 0xffffff, .2
        @light.position.set 0, 200, 100
        @light.castShadow = true
        @light.shadow.bias = .0001
        @light.shadow.camera.top = 180
        @light.shadow.camera.bottom = -100
        @light.shadow.camera.left = -120
        @light.shadow.camera.right = 120
        @light.shadow.mapSize.width = 2048 * 2
        @light.shadow.mapSize.height = 2048 * 2
        @scene.add @light

        @light2 = new THREE.PointLight 0xff9999, .3
        @light2.position.set -50, 100, -300
        @light2.castShadow = true
        @light2.shadow.bias = .0001
        @light2.shadow.camera.top = 180
        @light2.shadow.camera.bottom = -100
        @light2.shadow.camera.left = -120
        @light2.shadow.camera.right = 120
        @light2.shadow.mapSize.width = 2048 * 2
        @light2.shadow.mapSize.height = 2048 * 2
        @scene.add @light2

        @light3 = new THREE.PointLight 0x6666ff, .3
        @light3.position.set 50, 100, -300
        @light3.castShadow = true
        @light3.shadow.bias = .0001
        @light3.shadow.camera.top = 180
        @light3.shadow.camera.bottom = -100
        @light3.shadow.camera.left = -120
        @light3.shadow.camera.right = 120
        @light3.shadow.mapSize.width = 2048 * 2
        @light3.shadow.mapSize.height = 2048 * 2
        @scene.add @light3

        @light4 = new THREE.DirectionalLight 0xffffff, .2
        @light4.position.set 0, 200, -100
        @light4.castShadow = true
        @light4.shadow.bias = .0001
        @light4.shadow.camera.top = 180
        @light4.shadow.camera.bottom = -100
        @light4.shadow.camera.left = -120
        @light4.shadow.camera.right = 120
        @light4.shadow.mapSize.width = 2048 * 2
        @light4.shadow.mapSize.height = 2048 * 2
        @scene.add @light4

        @floor = new THREE.Mesh new THREE.PlaneGeometry( 2000, 2000 ), new THREE.MeshPhongMaterial { color: 0x888888, depthWrite: false }
        @floor.rotation.x = -Math.PI / 2
        @floor.receiveShadow = true
        @scene.add @floor

        ###
        @grid = new THREE.GridHelper 2000, 20, 0x000000, 0x000000
        @grid.material.opacity = .2
        @grid.material.transparent = true
        @scene.add @grid
        ###