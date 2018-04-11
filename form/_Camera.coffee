_ = Framer._

require './lib/OrbitControls'
{BaseClass} = require './_BaseClass.coffee'
{Animation} = require './_Animation.coffee'
{States} = require './_States.coffee'

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
            enableDamping: false
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

        @saveInitialProperties()

        @_states = new States @
    
    setupOrbitControls: (properties) ->
        @controls = new THREE.OrbitControls @nativeCamera, @sceneDOM
        @enablePan = properties.enablePan
        @enableZoom = properties.enableZoom
        @enableRotate = properties.enableRotate
        @enableDamping = properties.enableDamping
        @autoRotate = properties.autoRotate
        @autoRotateSpeed = properties.autoRotateSpeed
        @target = properties.target

    saveInitialProperties: () ->
        @initialProperties = @

    on: (eventName, cb) ->

        if eventName.includes 'change'
            callback = (e) -> cb(e.value)
            @nativeCamera.addEventListener eventName, callback

            Framer.CurrentContext.on 'reset', =>
                @nativeCamera.removeEventListener eventName, callback

    setPosition: (positions) ->
        @x = positions[0]
        @y = positions[1]
        @z = positions[2]
    
    setRotation: (rotations) ->
        @rotationX = rotations[0]
        @rotationY = rotations[1]
        @rotationZ = rotations[2]
    
    animate: (properties) ->
        new Animation @, properties
    
    lookAt: (a, b, c) ->
        if arguments.length == 1
            @nativeCamera.lookAt a
        else if arguments.length == 3
            @nativeCamera.lookAt a, b, c
    
    stateSwitch: (state) ->
        # Loop through states on model to find the specified one
        Object.keys(@states).map (k) => 
            if k == state
                @states.current = @states[k]

                # Loop through property keys on the state and apply the values to model
                Object.keys(@states.current).map (pk)  =>
                    @[pk] = @states.current[pk]
    
    stateCycle: (stateA, stateB) ->
        # Check if stateA or stateB already is the current state on model
        if @states.current == @states[stateA] || @states.current == @states[stateB]
            if @states.current == @states[stateA] then @animate stateB
            else if @states.current == @states[stateB] then @animate stateA
        else
            # If neither are current, animate to stateA
            @animate stateA

    @define 'position',
        get: -> @nativeCamera.position
    
    @define 'x',
        get: -> @nativeCamera.position.x
        set: (x) -> 
            @nativeCamera.position.x = x
            @controls.update() if @controls
            @nativeCamera.dispatchEvent {type: 'change:x', value: @x}
    
    @define 'y',
        get: -> @nativeCamera.position.y
        set: (y) -> 
            @nativeCamera.position.y = y
            @controls.update() if @controls
            @nativeCamera.dispatchEvent {type: 'change:y', value: @y}
    
    @define 'z',
        get: -> @nativeCamera.position.z
        set: (z) -> 
            @nativeCamera.position.z = z
            @controls.update() if @controls
            @nativeCamera.dispatchEvent {type: 'change:z', value: @z}

    @define 'rotation',
        get: -> @nativeCamera.rotation
    
    @define 'rotationX',
        get: -> THREE.Math.radToDeg @nativeCamera.rotation.x
        set: (x) -> 
            @nativeCamera.rotation.x = THREE.Math.degToRad x
            @controls.update() if @controls
            @nativeCamera.dispatchEvent {type: 'change:rotationX', value: @rotationX}
    
    @define 'rotationY',
        get: -> THREE.Math.radToDeg @nativeCamera.rotation.y
        set: (y) -> 
            @nativeCamera.rotation.y = THREE.Math.degToRad y
            @controls.update() if @controls
            @nativeCamera.dispatchEvent {type: 'change:rotationY', value: @rotationY}
    
    @define 'rotationZ',
        get: -> THREE.Math.radToDeg @nativeCamera.rotation.z
        set: (z) -> 
            @nativeCamera.rotation.z = THREE.Math.degToRad z
            @controls.update() if @controls
            @nativeCamera.dispatchEvent {type: 'change:rotationZ', value: @rotationZ}
    
    @define 'fov',
        get: -> @nativeCamera.fov
        set: (fov) -> 
            @nativeCamera.fov = fov
            @nativeCamera.dispatchEvent {type: 'change:fov', value: @fov}
    
    @define 'zoom',
        get: -> @nativeCamera.zoom
        set: (factor) -> 
            @nativeCamera.zoom = factor
            @nativeCamera.dispatchEvent {type: 'change:zoom', value: @zoom}
    
    @define 'near',
        get: -> @nativeCamera.near
        set: (near) -> 
            @nativeCamera.near = near
            @nativeCamera.dispatchEvent {type: 'change:near', value: @near}
    
    @define 'far',
        get: -> @nativeCamera.far
        set: (far) -> 
            @nativeCamera.far = far
            @nativeCamera.dispatchEvent {type: 'change:far', value: @far}
    
    @define 'aspect',
        get: -> @nativeCamera.aspect
        set: (aspect) -> 
            @nativeCamera.aspect = aspect
            @nativeCamera.dispatchEvent {type: 'change:aspect', value: @aspect}
    
    @define 'states',
        get: ->
            @_states.states
        set: (states) ->
            _.extend @states, states

    @define 'enablePan',
        get: -> @controls.enablePan
        set: (bool) ->
            @controls.enablePan = bool
            @nativeCamera.dispatchEvent {type: 'change:enablePan', value: @enablePan}
    
    @define 'enableZoom',
        get: -> @controls.enableZoom
        set: (bool) -> 
            @controls.enableZoom = bool
            @nativeCamera.dispatchEvent {type: 'change:enableZoom', value: @enableZoom}
    
    @define 'enableRotate',
        get: -> @controls.enableRotate
        set: (bool) -> 
            @controls.enableRotate = bool
            @nativeCamera.dispatchEvent {type: 'change:enableRotate', value: @enableRotate}
    
    @define 'enableDamping',
        get: -> @controls.enableDamping
        set: (bool) -> 
            @controls.enableDamping = bool
            @nativeCamera.dispatchEvent {type: 'change:enableDamping', value: @enableDamping}
    
    @define 'dampingFactor',
        get: -> @controls.dampingFactor
        set: (dampingFactor) -> 
            @controls.dampingFactor = dampingFactor
            @nativeCamera.dispatchEvent {type: 'change:dampingFactor', value: @dampingFactor}
    
    @define 'autoRotate',
        get: -> @controls.autoRotate
        set: (bool) -> 
            @controls.autoRotate = bool
            @nativeCamera.dispatchEvent {type: 'change:autoRotate', value: @autoRotate}
    
    @define 'autoRotateSpeed',
        get: -> @controls.autoRotateSpeed
        set: (speed) -> 
            @controls.autoRotateSpeed = speed
            @nativeCamera.dispatchEvent {type: 'change:autoRotateSpeed', value: @autoRotateSpeed}
    
    @define 'target',
        get: -> @controls.target
        set: (vector3) -> 
            @controls.target = vector3
            @nativeCamera.dispatchEvent {type: 'change:target', value: @target}