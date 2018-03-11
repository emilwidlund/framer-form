_ = Framer._

{BaseClass} = require './_BaseClass.coffee'

class exports.Camera extends BaseClass
    constructor: (properties={}) ->

        _.defaults properties,
            perspective: 35
            near: 0.1
            far: 10000

        @camera = new THREE.PerspectiveCamera(properties.perspective, properties.width / properties.height, properties.near, properties.far)
        @camera.position.x = 0
        @camera.position.y = 0
        @camera.position.z = 100
    
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