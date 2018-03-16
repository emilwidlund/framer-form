{Scene} = require './Scene.coffee'

class exports.Studio extends Scene
    constructor: (properties={}) ->
        super properties

        @scene.background = new THREE.Color 0x9181a0
        @scene.fog = new THREE.Fog 0x9181a0, 400, 1000

        @camera.y = 220
        @camera.z = 500
        @camera.rotationX = -15
        
        @hlight = new THREE.HemisphereLight 0xffffff, 0x444444
        @hlight.position.y = 200
        @scene.add @hlight

        @light = new THREE.PointLight 0xffffff, .1
        @light.position.set 0, 400, 0
        @light.castShadow = true
        @light.shadow.camera.far = 1000
        @light.shadow.bias = .0001
        @light.shadow.radius = 5
        @light.shadow.mapSize.width = 1024
        @light.shadow.mapSize.height = 1024
        @scene.add @light

        @light2 = new THREE.DirectionalLight 0xff9999, .3
        @light2.position.set -100, 200, -300
        @scene.add @light2

        @light3 = new THREE.DirectionalLight 0x6666ff, .2
        @light3.position.set 100, 200, -300
        @scene.add @light3

        @light4 = new THREE.DirectionalLight 0xff9999, .3
        @light4.position.set -100, 200, 300
        @scene.add @light4

        @light5 = new THREE.DirectionalLight 0x6666ff, .2
        @light5.position.set 100, 200, 300
        @scene.add @light5

        @floorGeo = new THREE.CircleGeometry 800, 100
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