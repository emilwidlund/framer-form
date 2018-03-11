_ = Framer._

{Model} = require './Model.coffee'

class exports.Animation extends Framer.EventEmitter
    constructor: (model, properties={}) ->
        super()

        if !properties
            throw new Error 'Please specify properties or a state to animate!'
        
        # If properties is a string, then it is a State Name
        if _.isString properties
            stateName = properties

            # Loop through states on model to find the specified state
            Object.keys(model.states).map (k) => 
                if k == stateName
                    # Set current state to specified state and apply state properties to properties variable
                    model.states.current = model.states[k]
                    properties = model.states[stateName]

        @model = model
        @mesh = model.mesh
        @properties = @filterProperties properties
        @options = _.defaults properties.options, 
            time: 1
            delay: 0

        @fps = 60
        @time = @options.time
        @renderedFrames = 0
        @totalFrames = @time * @fps
        @deltas = @calculateDeltas()


        # If there are differences between animation property values and the model's current property values (Delta)
        if @deltas.length
        # Delay the loop if specified, otherwise 0s
            Utils.delay @options.delay, =>
                # Create an interval that runs every 60 seconds
                @intervalDisposer = setInterval () => 
                    # Check if the amount of rendered frames exceeds amount of total frames that the animtion is supposed to run for
                    if @renderedFrames >= @totalFrames
                        # If it exceeds, dispose/end the animation
                        return @disposeInterval
                    
                    # Else keep the loop going
                    requestAnimationFrame @animationLoop
                    @renderedFrames++
                , 1000 / @fps
        
        # Make sure to dispose our animation loop if Framer's CurrentContext resets
        # Otherwise we'll leak loads of memory
        Framer.CurrentContext.on 'reset', =>
            if @intervalDisposer
                clearInterval @intervalDisposer

    filterProperties: (properties) ->
        props = Object.assign {}, properties
        delete props.options
        props

    calculateDeltas: () ->
        # Loop through all properties and calculate the delta between current model property value and
        # the value specified in this animation
        # This function returns an array of key/value pairs that contains the value (Delta) to animate for every property

        deltas = Object.keys(@properties).map (k) =>
            newObj = {}
            if @model[k] > @properties[k]
                newObj[k] = -Math.abs @model[k] - @properties[k]
            else if @model[k] < @properties[k]
                newObj[k] = Math.abs @model[k] - @properties[k]
            else
                null
            newObj
        
        deltas.filter (d) ->
            d


    animationLoop: () =>
        for delta, i in @deltas
            @model[Object.keys(delta)[0]] += Object.values(delta)[0] / (@time * @fps)

    disposeInterval: () ->
        clearInterval @intervalDisposer