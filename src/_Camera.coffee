_ = Framer._

{BaseClass} = require './_BaseClass.coffee'

class exports.Camera extends BaseClass
    constructor: (properties={}) ->

        _.defaults properties,
            x: 0
            y: 0
            z: 100
            rotationX: 0
            rotationY: 0
            rotationZ: 0
            perspective: 35
            near: 0.1
            far: 10000

        @camera = new THREE.PerspectiveCamera(
            properties.perspective, 
            properties.width / properties.height, 
            properties.near, 
            properties.far
        )

        @setPosition [properties.x, properties.y, properties.z]
        @setRotation [properties.rotationX, properties.rotationY, properties.rotationZ]
    
    setPosition: (positions) ->
        @x = positions[0]
        @y = positions[1]
        @z = positions[2]
    
    setRotation: (rotations) ->
        @rotationX = rotations[0]
        @rotationY = rotations[1]
        @rotationZ = rotations[2]
    
    @define 'x',
        get: -> @camera.position.x
        set: (x) -> @camera.position.x = x
    
    @define 'y',
        get: -> @camera.position.y
        set: (y) -> @camera.position.y = y
    
    @define 'z',
        get: -> @camera.position.z
        set: (z) -> @camera.position.z = z
    
    @define 'rotationX',
        get: -> THREE.Math.radToDeg @camera.rotation.x
        set: (x) -> @camera.rotation.x = THREE.Math.degToRad x
    
    @define 'rotationY',
        get: -> THREE.Math.radToDeg @camera.rotation.y
        set: (y) -> @camera.rotation.y = THREE.Math.degToRad y
    
    @define 'rotationZ',
        get: -> THREE.Math.radToDeg @camera.rotation.z
        set: (z) -> @camera.rotation.z = THREE.Math.degToRad z