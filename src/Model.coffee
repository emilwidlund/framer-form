require '../lib/OBJLoader.js'
{BaseClass} = require './BaseClass.coffee'
{Mesh} = require './Mesh.coffee'

class exports.Model extends BaseClass
    constructor: (properties={}) ->
        super()
        switch @getExtension properties.path
            when 'obj'
                @loadObj properties.path, (model) =>
                    @mesh = model
                    @boundingBox = new THREE.Box3().setFromObject @mesh
                    @setupModel properties

    getExtension: (path) ->
        path.split('.').pop()

    loadObj: (path, cb) ->
        @loader = new THREE.OBJLoader
        @loader.load path, (obj) ->
            cb(obj)

    setupModel: (properties) ->
        if properties.material
            @applyMaterial properties.material
        
        if properties.parent
            @addToRenderingInstance properties.parent

        @setScale properties.scale, properties.scaleX, properties.scaleY, properties.scaleZ
        @setPosition [properties.x, properties.y, properties.z]
        @setRotation [properties.rotationX, properties.rotationY, properties.rotationZ]
        
        if properties.visible
            @visible = properties.visible

        if properties.onLoad
            properties.onLoad @

    applyMaterial: (material) ->
        @mesh.traverse (c) ->
            if c instanceof THREE.Mesh
                c.material = material

    addToRenderingInstance: (parent) ->
        if parent.scene then parent.scene.add @mesh
        else parent.add @mesh
    
    on: (eventName, cb) ->
        @mesh.traverse (c) ->
            if c instanceof THREE.Mesh
                c.addEventListener eventName, cb


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
    
    animate: (properties) ->
        console.log properties

        framesRendered = 0
        framesTotal = properties.options.time * 60

        animation = () =>
            @mesh.rotation.y += THREE.Math.degToRad(properties.rotationY / (properties.options.time * 60))

        intervalDisposer = setInterval () -> 
            if framesRendered >= framesTotal
                return clearInterval intervalDisposer
            requestAnimationFrame animation
            framesRendered++
        , 1000 / 60

    @define 'scale',
        get: -> @mesh.scale,
        set: (scale) -> @mesh.scale.set(scale, scale, scale)
    
    @define 'scaleX',
        get: -> @mesh.scale.x,
        set: (scale) -> @mesh.scale.set(scale, @mesh.scale.y, @mesh.scale.z)

    @define 'scaleY',
        get: -> @mesh.scale.y,
        set: (scale) -> @mesh.scale.set(@mesh.scale.x, scale, @mesh.scale.z)
    
    @define 'scaleZ',
        get: -> @mesh.scale.z,
        set: (scale) -> @mesh.scale.set(@mesh.scale.x, @mesh.scale.y, scale)

    @define 'x',
        get: -> @mesh.position.x,
        set: (x) -> @mesh.position.x = x
    
    @define 'y',
        get: -> @mesh.position.y,
        set: (y) -> @mesh.position.y = y
    
    @define 'z',
        get: -> @mesh.position.z,
        set: (z) -> @mesh.position.z = z

    @define 'rotationX',
        get: -> @mesh.rotation.x,
        set: (x) -> @mesh.rotation.x = THREE.Math.degToRad(x)
    
    @define 'rotationY',
        get: -> @mesh.rotation.y,
        set: (y) -> @mesh.rotation.y = THREE.Math.degToRad(y)
    
    @define 'rotationZ',
        get: -> @mesh.rotation.z,
        set: (z) -> @mesh.rotation.z = THREE.Math.degToRad(z)
    
    @define 'parent',
        get: -> @mesh.parent,
        set: (parent) -> @mesh.parent = parent
    
    @define 'visible',
        get: -> @mesh.visible
        set: (bool) -> @mesh.visible = bool
    
    @define 'children',
        get: -> @mesh.children
    
    @define 'size',
        get: -> {
            height: @boundingBox.max.y - @boundingBox.min.y
            width: @boundingBox.max.x - @boundingBox.min.x
            depth: @boundingBox.max.z - @boundingBox.min.z
        }