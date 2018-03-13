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

    applyEasing: (t, b, c, d) ->

        t /= d
        c * t * t + b

        ###
        t /= d / 2

        if t < 1 
            c / 2 * t * t + b
        
        t--
	    
        -c / 2 * (t * (t - 2) - 1) + b
        ###

    animationLoop: () =>

        for delta, i in @deltas

            prop = Object.keys(delta)[0]
            deltaValue = Object.values(delta)[0]

            finalValue = @applyEasing(@renderedFrames, 0, deltaValue, @totalFrames)
            console.log finalValue

            @model[prop] = finalValue

    disposeInterval: () ->
        clearInterval @intervalDisposer
    




    easeInQuad: (x, t, b, c, d) ->
        c * (t /= d) * t + b

    easeOutQuad: (x, t, b, c, d) ->
        -c * (t /= d) * (t - 2) + b

    easeInOutQuad: (x, t, b, c, d) ->
        if (t /= d / 2) < 1
            c / 2 * t * t + b
        else
            -c / 2 * ((--t) * (t - 2) - 1) + b

    easeInCubic: (x, t, b, c, d) ->
        c * (t /= d) * t * t + b

    easeOutCubic: (x, t, b, c, d) ->
        c * ((t = t / d - 1) * t * t + 1) + b

    easeInOutCubic: (x, t, b, c, d) ->
        if (t /= d / 2) < 1 
            c / 2 * t * t * t + b
        else 
            c / 2 * ((t -= 2) * t * t + 2) + b

    easeInQuart: (x, t, b, c, d) ->
        c * (t /= d) * t * t * t + b

    easeOutQuart: (x, t, b, c, d) ->
        -c * ((t = t / d - 1) * t * t * t - 1) + b

    easeInOutQuart: (x, t, b, c, d) ->
        if (t /= d / 2) < 1
            c / 2 * t * t * t * t + b
        else 
            -c / 2 * ((t -= 2) * t * t * t - 2) + b

    easeInQuint: (x, t, b, c, d) ->
        c * (t /= d) * t * t * t * t + b

    easeOutQuint: (x, t, b, c, d) ->
        c * ((t = t / d - 1) * t * t * t * t + 1) + b

    easeInOutQuint: (x, t, b, c, d) ->
        if (t /= d / 2) < 1
            c / 2 * t * t * t * t * t + b
        else 
            c / 2 * ((t -= 2) * t * t * t * t + 2) + b

    easeInSine: (x, t, b, c, d) ->
        -c * Math.cos(t / d * (Math.PI / 2)) + c + b

    easeOutSine: (x, t, b, c, d) ->
        c * Math.sin(t / d * (Math.PI / 2)) + b

    easeInOutSine: (x, t, b, c, d) ->
        -c / 2 * (Math.cos(Math.PI * t / d) - 1) + b

    easeInExpo: (x, t, b, c, d) ->
        (t == 0) ? b : c * Math.pow(2, 10 * (t / d - 1)) + b

    easeOutExpo: (x, t, b, c, d) ->
        (t == d) ? b + c : c * (-Math.pow(2, -10 * t / d) + 1) + b

    easeInOutExpo: (x, t, b, c, d) ->
        if t == 0
            b
        if t == d
            b + c
        if (t /= d / 2) < 1 
            c / 2 * Math.pow(2, 10 * (t - 1)) + b
        else 
            c / 2 * (-Math.pow(2, -10 * --t) + 2) + b

    easeInCirc: (x, t, b, c, d) ->
        -c * (Math.sqrt(1 - (t /= d) * t) - 1) + b

    easeOutCirc: (x, t, b, c, d) ->
        c * Math.sqrt(1 - (t = t / d - 1) * t) + b

    easeInOutCirc: (x, t, b, c, d) ->
        if (t /= d / 2) < 1
            -c / 2 * (Math.sqrt(1 - t * t) - 1) + b
        else 
            c / 2 * (Math.sqrt(1 - (t -= 2) * t) + 1) + b

    easeInElastic: (x, t, b, c, d) ->
        s = 1.70158
        p = 0
        a = c

        if t == 0 
            b  
        if (t /= d) == 1
            b + c

        if !p 
            p = d * .3
        if a < Math.abs(c)
            a = c
            s = p / 4
        else 
            s = p / (2 * Math.PI) * Math.asin (c / a)

        -(a * Math.pow(2, 10 * (t -= 1)) * Math.sin((t * d - s) * (2 * Math.PI) / p )) + b

    easeOutElastic: (x, t, b, c, d) ->
        s = 1.70158
        p = 0
        a = c

        if t == 0 
            b
        if (t /= d) == 1 
            b + c 

        if !p
            p = d * .3
        if a < Math.abs(c)
            a = c
            s = p / 4
        else 
            s = p / (2 * Math.PI) * Math.asin (c / a)

        a * Math.pow(2, -10 * t) * Math.sin((t * d - s) * (2 * Math.PI) / p) + c + b

    easeInOutElastic: (x, t, b, c, d) ->
        s = 1.70158
        p = 0
        a = c

        if t == 0
            b
        if (t /= d / 2) == 2
            b + c 
        
        if !p 
            p = d * (.3 * 1.5)
        if a < Math.abs(c)
            a = c
            s = p / 4
        else 
            s = p / (2 * Math.PI) * Math.asin (c / a)
        if (t < 1) 
            -.5 * (a * Math.pow(2, 10 * (t -= 1)) * Math.sin((t * d - s) * (2 * Math.PI) / p)) + b
        
        a * Math.pow(2, -10 * (t -= 1)) * Math.sin((t * d - s) * (2 * Math.PI) / p) * .5 + c + b