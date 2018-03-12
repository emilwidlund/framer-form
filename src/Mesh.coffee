_ = Framer._

class exports.Mesh extends THREE.Mesh

    @define = (propertyName, descriptor) ->
        if descriptor.readonly
            descriptor.set = (value) ->
                throw Error("#{@constructor.name}.#{propertyName} is readonly")

        Object.defineProperty(@prototype, propertyName, descriptor)

    constructor: (properties={}) ->
        super properties.geometry, properties.material

        _.defaults properties,
            castShadow: true
            receiveShadow: true

        @setupShadowSettings properties

        if properties.parent
            @addToRenderingInstance properties.parent
        
        @setScale properties.scale, properties.scaleX, properties.scaleY, properties.scaleZ
        @setPosition [properties.x, properties.y, properties.z]
        @setRotation [properties.rotationX, properties.rotationY, properties.rotationZ]

    setupShadowSettings: (properties) ->
        @castShadow = properties.castShadow
        @receiveShadow = properties.receiveShadow

    addToRenderingInstance: (parent) ->
        if parent.scene then parent.scene.add @
        else parent.add @

    setScale: (uniformScale, scaleX, scaleY, scaleZ) ->
        if uniformScale
            @scale = uniformScale || 1
        else
            @scaleX = scaleX || 1
            @scaleY = scaleY || 1
            @scaleZ = scaleZ || 1
    
    setPosition: (position) ->
        @x = position[0] || 0
        @y = position[1] || 0
        @z = position[2] || 0

    setRotation: (rotation) ->
        @rotationX = rotation[0] || 0
        @rotationY = rotation[1] || 0
        @rotationZ = rotation[2] || 0

    @define 'scale',
        get: -> @scale.x,
        set: (scale) -> @scale.set(scale, scale, scale)
    
    @define 'scaleX',
        get: -> @scale.x,
        set: (scale) -> @scale.set(scale, @scale.y, @scale.z)

    @define 'scaleY',
        get: -> @scale.y,
        set: (scale) -> @scale.set(@scale.x, scale, @scale.z)
    
    @define 'scaleZ',
        get: -> @scale.z,
        set: (scale) -> @scale.set(@scale.x, @scale.y, scale)

    @define 'x',
        get: -> @position.x,
        set: (x) -> @position.x = x
    
    @define 'y',
        get: -> @position.y,
        set: (y) -> @position.y = y
    
    @define 'z',
        get: -> @position.z,
        set: (z) -> @position.z = z

    @define 'rotationX',
        get: -> THREE.Math.radToDeg(@rotation.x),
        set: (x) -> @rotation.x = THREE.Math.degToRad(x)
    
    @define 'rotationY',
        get: -> THREE.Math.radToDeg(@rotation.y),
        set: (y) -> @rotation.y = THREE.Math.degToRad(y)
    
    @define 'rotationZ',
        get: -> THREE.Math.radToDeg(@rotation.z),
        set: (z) -> @rotation.z = THREE.Math.degToRad(z)