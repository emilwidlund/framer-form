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
        @light.shadow.radius = 20
        @light.shadow.mapSize.width = 2048
        @light.shadow.mapSize.height = 2048
        @scene.add @light

        @light2 = new THREE.DirectionalLight 0xff9999, .3
        @light2.position.set -100, 100, -300
        @scene.add @light2

        @light3 = new THREE.DirectionalLight 0x6666ff, .2
        @light3.position.set 100, 100, -300
        @scene.add @light3

        @floorGeo = new THREE.PlaneGeometry 2000, 2000
        @floorMat = new THREE.MeshStandardMaterial
            roughness: .6
            color: 0xaaaaaa
            metalness: 0.2
            bumpScale: 0.0005
        @floor = new THREE.Mesh @floorGeo, @floorMat
        @floor.rotation.x = -Math.PI / 2
        @floor.receiveShadow = true
        @scene.add @floor

        ###
        @grid = new THREE.GridHelper 2000, 20, 0x000000, 0x000000
        @grid.material.opacity = .2
        @grid.material.transparent = true
        @scene.add @grid
        ###