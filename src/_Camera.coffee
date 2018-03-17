_ = Framer._

require './lib/OrbitControls'
{BaseClass} = require './_BaseClass.coffee'

class exports.Camera extends BaseClass
    constructor: (properties={}, sceneDOM) ->
        super()

        @sceneDOM = sceneDOM

        _.defaults properties,
            x: 0
            y: 0
            z: 500
            rotationX: 0
            rotationY: 0
            rotationZ: 0
            fov: 35
            near: 0.1
            far: 10000
            enablePan: false
            enableZoom: false
            enableRotate: false
            autoRotate: false
            autoRotateSpeed: 10
            target: new THREE.Vector3 0, 0, 0

        @nativeCamera = new THREE.PerspectiveCamera(
            properties.fov, 
            properties.aspect, 
            properties.near, 
            properties.far
        )

        if properties.orbitControls
            @setupOrbitControls properties

        @setPosition [properties.x, properties.y, properties.z]
        @setRotation [properties.rotationX, properties.rotationY, properties.rotationZ]
    
    setupOrbitControls: (properties) ->
        @controls = new THREE.OrbitControls @nativeCamera, @sceneDOM
        @controls.enablePan = properties.enablePan
        @controls.enableZoom = properties.enableZoom
        @controls.enableRotate = properties.enableRotate
        @controls.autoRotate = properties.autoRotate
        @controls.autoRotateSpeed = properties.autoRotateSpeed
        @controls.target = properties.target

    setPosition: (positions) ->
        @x = positions[0]
        @y = positions[1]
        @z = positions[2]
    
    setRotation: (rotations) ->
        @rotationX = rotations[0]
        @rotationY = rotations[1]
        @rotationZ = rotations[2]

    @define 'position',
        get: -> @nativeCamera.position
    
    @define 'x',
        get: -> @nativeCamera.position.x
        set: (x) -> 
            @nativeCamera.position.x = x
            @controls.update() if @controls
    
    @define 'y',
        get: -> @nativeCamera.position.y
        set: (y) -> 
            @nativeCamera.position.y = y
            @controls.update() if @controls
    
    @define 'z',
        get: -> @nativeCamera.position.z
        set: (z) -> 
            @nativeCamera.position.z = z
            @controls.update() if @controls

    @define 'rotation',
        get: -> @nativeCamera.rotation
    
    @define 'rotationX',
        get: -> THREE.Math.radToDeg @nativeCamera.rotation.x
        set: (x) -> 
            @nativeCamera.rotation.x = THREE.Math.degToRad x
            @controls.update() if @controls
    
    @define 'rotationY',
        get: -> THREE.Math.radToDeg @nativeCamera.rotation.y
        set: (y) -> 
            @nativeCamera.rotation.y = THREE.Math.degToRad y
            @controls.update() if @controls
    
    @define 'rotationZ',
        get: -> THREE.Math.radToDeg @nativeCamera.rotation.z
        set: (z) -> 
            @nativeCamera.rotation.z = THREE.Math.degToRad z
            @controls.update() if @controls
    
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