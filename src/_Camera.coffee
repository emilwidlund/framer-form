_ = Framer._

{BaseClass} = require './_BaseClass.coffee'

class exports.Camera extends BaseClass
    constructor: (properties={}) ->
        super()

        _.defaults properties,
            x: 0
            y: 0
            z: 100
            rotationX: 0
            rotationY: 0
            rotationZ: 0
            fov: 35
            near: 0.1
            far: 10000

        @nativeCamera = new THREE.PerspectiveCamera(
            properties.fov, 
            properties.aspect, 
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
        get: -> @nativeCamera.position.x
        set: (x) -> @nativeCamera.position.x = x
    
    @define 'y',
        get: -> @nativeCamera.position.y
        set: (y) -> @nativeCamera.position.y = y
    
    @define 'z',
        get: -> @nativeCamera.position.z
        set: (z) -> @nativeCamera.position.z = z
    
    @define 'rotationX',
        get: -> THREE.Math.radToDeg @nativeCamera.rotation.x
        set: (x) -> @nativeCamera.rotation.x = THREE.Math.degToRad x
    
    @define 'rotationY',
        get: -> THREE.Math.radToDeg @nativeCamera.rotation.y
        set: (y) -> @nativeCamera.rotation.y = THREE.Math.degToRad y
    
    @define 'rotationZ',
        get: -> THREE.Math.radToDeg @nativeCamera.rotation.z
        set: (z) -> @nativeCamera.rotation.z = THREE.Math.degToRad z
    
    @define 'fov',
        get: -> @nativeCamera.fov
        set: (fov) -> @nativeCamera.fov = fov
    
    @define 'zoom',
        get: -> @nativeCamera.zoom
        set: (factor) -> @nativeCamera.zoom = factor
    
    @define 'near',
        get: -> @nativeCamera.near
        set: (near) -> @nativeCamera.near = near
    
    @define 'far',
        get: -> @nativeCamera.far
        set: (far) -> @nativeCamera.far = far
    
    @define 'aspect',
        get: -> @nativeCamera.aspect
        set: (aspect) -> @nativeCamera.aspect = aspect