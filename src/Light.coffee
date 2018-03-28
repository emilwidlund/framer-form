_ = Framer._

{BaseClass} = require './_BaseClass.coffee'
{Animation} = require './_Animation.coffee'
{States} = require './_States.coffee'

class exports.Light extends BaseClass
    constructor: (properties) ->
        super()

        window.gtag 'event', 'New',
            'event_category': 'Light'

        if !properties.type
            throw Error 'Please specify a light type!'
        
        @properties = _.defaults properties

        @setupLight()

    setupLight: ->
        switch @properties.type
            when 'point'
                @light = new THREE.PointLight(
                    new THREE.Color @properties.color, 
                    @properties.intensity, 
                    @properties.distance, 
                    @properties.decay
                )
            when 'directional'
                @light = new THREE.DirectionalLight(
                    new THREE.Color @properties.color, 
                    @properties.intensity
                )
            when 'ambient'
                @light = new THREE.AmbientLight(
                    new THREE.Color @properties.color, 
                    @properties.intensity
                )
            when 'hemisphere'
                @light = new THREE.HemisphereLight(
                    new THREE.Color @properties.skyColor, 
                    new THREE.Color @properties.groundColor, 
                    @properties.intensity
                )
            when 'rectarea'
                @light = new THREE.RectAreaLight(
                    new THREE.Color @properties.color, 
                    @properties.intensity, 
                    @properties.width, 
                    @properties.height
                )
            when 'spot'
                @light = new THREE.SpotLight(
                    new THREE.Color @properties.color, 
                    @properties.intensity, 
                    @properties.distance, 
                    @properties.angle, 
                    @properties.penumbra, 
                    @properties.decay
                )

        @addToRenderingInstance @properties.parent

        @applyProperties()

        @saveInitialProperties()
        
        @_states = new States @

    addToRenderingInstance: (parent) ->
        if parent.scene then parent.scene.add @light
        else parent.add @light
    
    applyProperties: (properties) ->
        Object.keys(@properties).map (k) =>
            @[k] = @properties[k]

    saveInitialProperties: () ->
        @initialProperties = @

    on: (eventName, cb) ->

        if eventName.includes 'change'
            callback = (e) -> cb(e.value)
            @light.addEventListener eventName, callback

            Framer.CurrentContext.on 'reset', =>
                @light.removeEventListener eventName, callback

    animate: (properties) ->
        new Animation @, properties

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


    # GENERIC OBJECT3D PROPERTIES

    @define 'position',
        get: -> @light.position

    @define 'x',
        get: -> @light.position.x,
        set: (x) -> 
            @light.position.x = x
            @light.dispatchEvent {type: 'change:x', value: @x}
    
    @define 'y',
        get: -> @light.position.y,
        set: (y) -> 
            @light.position.y = y
            @light.dispatchEvent {type: 'change:y', value: @y}
    
    @define 'z',
        get: -> @light.position.z,
        set: (z) -> 
            @light.position.z = z
            @light.dispatchEvent {type: 'change:z', value: @z}

    @define 'rotation',
        get: -> @light.rotation

    @define 'rotationX',
        get: -> THREE.Math.radToDeg(@light.rotation.x),
        set: (x) -> 
            @light.rotation.x = THREE.Math.degToRad(x)
            @light.dispatchEvent {type: 'change:rotationX', value: @rotationX}
    
    @define 'rotationY',
        get: -> THREE.Math.radToDeg(@light.rotation.y),
        set: (y) -> 
            @light.rotation.y = THREE.Math.degToRad(y)
            @light.dispatchEvent {type: 'change:rotationY', value: @rotationY}
    
    @define 'rotationZ',
        get: -> THREE.Math.radToDeg(@light.rotation.z),
        set: (z) -> 
            @light.rotation.z = THREE.Math.degToRad(z)
            @light.dispatchEvent {type: 'change:rotationZ', value: @rotationZ}
    
    @define 'visible',
        get: -> @light.visible
        set: (bool) -> 
            @light.visible = bool
            @light.dispatchEvent {type: 'change:visible', value: @visible}
    
    @define 'states',
        get: ->
            @_states.states
        set: (states) ->
            _.extend @states, states

    # LIGHT PROPERTIES

    @define 'color',
        get: -> @light.color
        set: (color) ->
            @light.color = new THREE.Color color
            @light.dispatchEvent {type: 'change:color', value: @color}
    
    @define 'intensity',
        get: -> @light.intensity
        set: (intensity) ->
            @light.intensity = intensity
            @light.dispatchEvent {type: 'change:intensity', value: @intensity}

    @define 'angle',
        get: -> @light.angle
        set: (angle) ->
            @light.angle = angle
            @light.dispatchEvent {type: 'change:angle', value: @angle}
    
    @define 'castShadow',
        get: -> @light.castShadow
        set: (bool) ->
            @light.castShadow = bool
            @light.dispatchEvent {type: 'change:castShadow', value: @castShadow}
    
    @define 'decay',
        get: -> @light.decay
        set: (decay) ->
            @light.decay = decay
            @light.dispatchEvent {type: 'change:decay', value: @decay}
    
    @define 'distance',
        get: -> @light.distance
        set: (distance) ->
            @light.distance = distance
            @light.dispatchEvent {type: 'change:distance', value: @distance}
    
    @define 'penumbra',
        get: -> @light.penumbra
        set: (penumbra) ->
            @light.penumbra = penumbra
            @light.dispatchEvent {type: 'change:penumbra', value: @penumbra}
    
    @define 'power',
        get: -> @light.power
        set: (power) ->
            @light.power = power
            @light.dispatchEvent {type: 'change:power', value: @power}
    
    @define 'shadow',
        get: -> @light.shadow
        set: (shadow) ->
            @light.shadow = shadow
    
    @define 'target',
        get: -> @light.target
        set: (target) ->
            @light.target = target
            @light.dispatchEvent {type: 'change:target', value: @target}
    
    @define 'width',
        get: -> @light.width
        set: (width) ->
            @light.width = width
            @light.dispatchEvent {type: 'change:width', value: @width}
    
    @define 'height',
        get: -> @light.height
        set: (height) ->
            @light.height = height
            @light.dispatchEvent {type: 'change:height', value: @height}
    
    @define 'groundColor',
        get: -> @light.groundColor
        set: (groundColor) ->
            @light.groundColor = new THREE.Color groundColor
            @light.dispatchEvent {type: 'change:groundColor', value: @groundColor}
    
    @define 'skyColor',
        get: -> @light.skyColor
        set: (skyColor) ->
            @light.skyColor = new THREE.Color skyColor
            @light.dispatchEvent {type: 'change:skyColor', value: @skyColor}