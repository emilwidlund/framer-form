_ = Framer._

# CLASSES

{BaseClass} = require './_BaseClass.coffee'
{Animation} = require './_Animation.coffee'
{States} = require './_States.coffee'

# LOADERS

{OBJ} = require './loaders/OBJ.coffee'
{FBX} = require './loaders/FBX.coffee'
{GLTF} = require './loaders/GLTF.coffee'
{Collada} = require './loaders/Collada.coffee'
{JSONObject} = require './loaders/JSONObject.coffee'
{TDS} = require './loaders/TDS.coffee'

class exports.Model extends BaseClass
    constructor: (properties={}) ->
        super()

        _.defaults properties,
            animate: true
            castShadow: true
            receiveShadow: true
            reposition: true

        switch @getExtension properties.path
            when 'obj'
                new OBJ properties, (model) =>
                    @mesh = model
                    @setupModel properties
            when 'fbx'
                new FBX properties, (model) =>
                    @mesh = model
                    @setupModel properties
            when 'gltf' || 'glb'
                new GLTF properties, (model) =>
                    @mesh = model
                    @setupModel properties
            when 'dae'
                new Collada properties, (model) =>
                    @mesh = model
                    @setupModel properties
            when 'json'
                new JSONObject properties, (model) =>
                    @mesh = model
                    @setupModel properties
            when '3DS' || '3ds'
                new TDS properties, (model) =>
                    @mesh = model
                    @setupModel properties


    getExtension: (path) ->
        path.split('.').pop()

    setupModel: (properties) ->
        if properties.reposition
            @repositionMesh()

        @pivot = new THREE.Group
        @pivot.add @mesh

        @saveInitialProperties()

        if properties.material
            @applyMaterial properties.material
        
        if properties.map
            new THREE.TextureLoader().load properties.map, (map) =>
                @mesh.material.map = map
                @mesh.material.needsUpdate = true
        
        @setupShadowSettings properties
        
        if properties.smoothShading
            @mesh.traverse (c) ->
                if c instanceof THREE.Mesh
                    c.material.shading = THREE.SmoothShading
        
        if properties.animate && @mesh.animations && @mesh.animations[0]
            @handleAnimations properties

        if properties.parent
            @addToRenderingInstance properties.parent

        @setScale properties.scale, properties.scaleX, properties.scaleY, properties.scaleZ
        @setPosition [properties.x, properties.y, properties.z]
        @setRotation [properties.rotationX, properties.rotationY, properties.rotationZ]
        @setMid(
            midX: properties.midX
            midY: properties.midY
            midZ: properties.midZ
        )

        if properties.visible
            @visible = properties.visible
        
        @_states = new States @

        if properties.onLoad
            properties.onLoad @

    repositionMesh: () ->
        @boundingBox = new THREE.Box3().setFromObject @mesh
        @offset = @boundingBox.getCenter @mesh.position
        @mesh.position.multiplyScalar -1

    saveInitialProperties: () ->
        @initialProperties = @

    applyMaterial: (material) ->
        @mesh.traverse (c) ->
            if c instanceof THREE.Mesh
                c.material = material


    setupShadowSettings: (properties) ->
        @mesh.traverse (c) ->
            if c instanceof THREE.Mesh
                c.castShadow = properties.castShadow
                c.receiveShadow = properties.receiveShadow

    addToRenderingInstance: (parent) ->
        if parent.scene then parent.scene.add @pivot
        else parent.add @pivot
    
    handleAnimations: (properties) ->
        if _.isNumber properties.animationClip
            @animationIndex = properties.animationClip - 1
        else
            @animationIndex = 0

        @clock = new THREE.Clock
        @mesh.mixer = new THREE.AnimationMixer @mesh

        @action = @mesh.mixer.clipAction @mesh.animations[@animationIndex]
        @action.play()
        
        @updateMixer()

        Framer.CurrentContext.on 'reset', =>
            cancelAnimationFrame @mixerRequestId
        
    updateMixer: () =>
        @mixerRequestId = requestAnimationFrame @updateMixer
        @mesh.mixer.update @clock.getDelta()
    
    on: (eventName, cb) ->

        if eventName.includes 'change'

            callback = (e) -> cb(e.value)

            @pivot.addEventListener eventName, callback

            Framer.CurrentContext.on 'reset', =>
                @pivot.removeEventListener eventName, callback

        else
            @mesh.traverse (c) ->
                if c instanceof THREE.Mesh

                    callback = () -> cb()

                    c.addEventListener eventName, callback

                    Framer.CurrentContext.on 'reset', =>
                        c.removeEventListener eventName, callback


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

    setMid: (mid) ->
        Object.keys(mid).map (k) =>
            if mid[k]
                @[k] = mid[k]
    
    animate: (properties) ->
        new Animation @, properties
    
    lookAt: (a, b, c) ->
        if arguments.length == 1
            @pivot.lookAt a
        else if arguments.length == 3
            @pivot.lookAt a, b, c
    
    stateSwitch: (state) ->
        # Loop through states on model to find the specified one
        Object.keys(@states).map (k) => 
            if k == state
                @states.current = @states[k]

                # Loop through property keys on the state and apply the values to model
                Object.keys(@states.current).map (pk)  =>
                    @[pk] = @states.current[pk]
    
    stateCycle: () ->
        if arguments.length

            for s, i in arguments
                if _.isEqual @states[s], @states.current
                    if i == (arguments.length - 1)
                        nextState = 0
                    else
                        nextState = i + 1
            
            if nextState == undefined
                nextState = 0

            @animate arguments[nextState]

        else
            states = Object.keys(@states)
            states.splice(1, 1)

            for s, i in states
                if _.isEqual @states[s], @states.current
                    if i == (states.length - 1)
                        nextState = 0
                    else
                        nextState = i + 1

            @animate states[nextState]

    @define 'scale',
        get: -> @pivot.scale.x,
        set: (scale) -> 
            @pivot.scale.set(scale, scale, scale)
            @pivot.dispatchEvent {type: 'change:scale', value: @scale}
    
    @define 'scaleX',
        get: -> @pivot.scale.x,
        set: (scale) -> 
            @pivot.scale.set(scale, @pivot.scale.y, @pivot.scale.z)
            @pivot.dispatchEvent {type: 'change:scaleX', value: @scaleX}

    @define 'scaleY',
        get: -> @pivot.scale.y,
        set: (scale) -> 
            @pivot.scale.set(@pivot.scale.x, scale, @pivot.scale.z)
            @pivot.dispatchEvent {type: 'change:scaleY', value: @scaleY}
    
    @define 'scaleZ',
        get: -> @pivot.scale.z,
        set: (scale) -> 
            @pivot.scale.set(@pivot.scale.x, @pivot.scale.y, scale)
            @pivot.dispatchEvent {type: 'change:scaleZ', value: @scaleZ}

    @define 'position',
        get: -> @pivot.position

    @define 'x',
        get: -> @pivot.position.x,
        set: (x) -> 
            @pivot.position.x = x
            @pivot.dispatchEvent {type: 'change:x', value: @x}
    
    @define 'y',
        get: -> @pivot.position.y,
        set: (y) -> 
            @pivot.position.y = y
            @pivot.dispatchEvent {type: 'change:y', value: @y}
    
    @define 'z',
        get: -> @pivot.position.z,
        set: (z) -> 
            @pivot.position.z = z
            @pivot.dispatchEvent {type: 'change:z', value: @z}

    @define 'rotation',
        get: -> @pivot.rotation

    @define 'rotationX',
        get: -> THREE.Math.radToDeg(@pivot.rotation.x),
        set: (x) -> 
            @pivot.rotation.x = THREE.Math.degToRad(x)
            @pivot.dispatchEvent {type: 'change:rotationX', value: @rotationX}
    
    @define 'rotationY',
        get: -> THREE.Math.radToDeg(@pivot.rotation.y),
        set: (y) -> 
            @pivot.rotation.y = THREE.Math.degToRad(y)
            @pivot.dispatchEvent {type: 'change:rotationY', value: @rotationY}
    
    @define 'rotationZ',
        get: -> THREE.Math.radToDeg(@pivot.rotation.z),
        set: (z) -> 
            @pivot.rotation.z = THREE.Math.degToRad(z)
            @pivot.dispatchEvent {type: 'change:rotationZ', value: @rotationZ}
    
    @define 'midX',
        set: (midX) -> @mesh.position.x = -midX
    
    @define 'midY',
        set: (midY) -> @mesh.position.y = -midY
    
    @define 'midZ',
        set: (midZ) -> @mesh.position.z = -midZ

    @define 'parent',
        get: -> @pivot.parent,
        set: (parent) -> 
            @pivot.parent = parent
            @pivot.dispatchEvent {type: 'change:parent', value: @parent}
    
    @define 'visible',
        get: -> @pivot.visible
        set: (bool) -> 
            @pivot.visible = bool
            @pivot.dispatchEvent {type: 'change:visible', value: @visible}
    
    @define 'children',
        get: -> @pivot.children
    
    @define 'size',
        get: -> {
            height: @boundingBox.max.y - @boundingBox.min.y
            width: @boundingBox.max.x - @boundingBox.min.x
            depth: @boundingBox.max.z - @boundingBox.min.z
        }
    
    @define 'states',
        get: ->
            @_states.states
        set: (states) ->
            _.extend @states, states
    
    @define 'animationClip',
        get: -> @animationIndex + 1,
        set: (animation) -> 
            if @mesh.animations[animation - 1]
                @animationIndex = animation - 1
                @action = @mesh.mixer.clipAction @mesh.animations[@animationIndex]
                @action.play()