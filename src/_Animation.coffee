_ = Framer._

{Model} = require './Model.coffee'

class exports.Animation extends Framer.EventEmitter
    constructor: (model, properties={}) ->
        super()

        window.gtag 'event', 'New',
            'event_category': 'Animation'
        
        if !properties
                throw Error 'Please specify properties or a state to animate!'
            
        # If properties is a string, then it is a State Name
        if _.isString properties
            stateName = properties

            # Loop through states on model to find the specified state
            Object.keys(model.states).map (k) => 
                if k == stateName
                    # Set current state to specified state and apply state properties to properties variable
                    model.states.current = model.states[k]
                    properties = model.states[stateName]

        @properties = @filterProperties properties
        @options = _.defaults properties.options, 
            time: 1
            delay: 0
            curve: 'linear'

        # Delay the loop if specified, otherwise 0s
        Utils.delay @options.delay, =>

            @model = model
            @mesh = model.mesh || model.light || model.nativeCamera
            @fps = 60
            @time = @options.time
            @renderedFrames = 0
            @totalFrames = @time * @fps
            @modelPropertyInitialValues = {}
            @deltas = @calculateDeltas()


            # If there are differences between animation property values and the model's current property values (Delta)
            if @deltas.length
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

            @modelPropertyInitialValues[k] = @model[k]

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

        if @options.curve.includes 'ease'
            @[@options.curve] t, b, c, d
        else
            @linear t, b, c, d

    animationLoop: () =>

        for delta, i in @deltas

            prop = Object.keys(delta)[0]
            deltaValue = Object.values(delta)[0]

            easedValue = @applyEasing(@renderedFrames, @modelPropertyInitialValues[prop], deltaValue, @totalFrames)

            @model[prop] = easedValue

    disposeInterval: () ->
        clearInterval @intervalDisposer
    



    linear: (t, b, c, d) ->
        c * t / d + b

    easeInQuad: (t, b, c, d) ->
        c * (t /= d) * t + b

    easeOutQuad: (t, b, c, d) ->
        -c * (t /= d) * (t - 2) + b

    easeInOutQuad: (t, b, c, d) ->
        if (t /= d / 2) < 1
            c / 2 * t * t + b
        else
            -c / 2 * ((--t) * (t - 2) - 1) + b

    easeInCubic: (t, b, c, d) ->
        c * (t /= d) * t * t + b

    easeOutCubic: (t, b, c, d) ->
        c * ((t = t / d - 1) * t * t + 1) + b

    easeInOutCubic: (t, b, c, d) ->
        if (t /= d / 2) < 1 
            c / 2 * t * t * t + b
        else 
            c / 2 * ((t -= 2) * t * t + 2) + b

    easeInQuart: (t, b, c, d) ->
        c * (t /= d) * t * t * t + b

    easeOutQuart: (t, b, c, d) ->
        -c * ((t = t / d - 1) * t * t * t - 1) + b

    easeInOutQuart: (t, b, c, d) ->
        if (t /= d / 2) < 1
            c / 2 * t * t * t * t + b
        else 
            -c / 2 * ((t -= 2) * t * t * t - 2) + b

    easeInQuint: (t, b, c, d) ->
        c * (t /= d) * t * t * t * t + b

    easeOutQuint: (t, b, c, d) ->
        c * ((t = t / d - 1) * t * t * t * t + 1) + b

    easeInOutQuint: (t, b, c, d) ->
        if (t /= d / 2) < 1
            c / 2 * t * t * t * t * t + b
        else 
            c / 2 * ((t -= 2) * t * t * t * t + 2) + b

    easeInSine: (t, b, c, d) ->
        -c * Math.cos(t / d * (Math.PI / 2)) + c + b

    easeOutSine: (t, b, c, d) ->
        c * Math.sin(t / d * (Math.PI / 2)) + b

    easeInOutSine: (t, b, c, d) ->
        -c / 2 * (Math.cos(Math.PI * t / d) - 1) + b

    easeInExpo: (t, b, c, d) ->
        (t == 0) ? b : c * Math.pow(2, 10 * (t / d - 1)) + b

    easeOutExpo: (t, b, c, d) ->
        (t == d) ? b + c : c * (-Math.pow(2, -10 * t / d) + 1) + b

    easeInOutExpo: (t, b, c, d) ->
        if t == 0
            b
        if t == d
            b + c
        if (t /= d / 2) < 1 
            c / 2 * Math.pow(2, 10 * (t - 1)) + b
        else 
            c / 2 * (-Math.pow(2, -10 * --t) + 2) + b

    easeInCirc: (t, b, c, d) ->
        -c * (Math.sqrt(1 - (t /= d) * t) - 1) + b

    easeOutCirc: (t, b, c, d) ->
        c * Math.sqrt(1 - (t = t / d - 1) * t) + b

    easeInOutCirc: (t, b, c, d) ->
        if (t /= d / 2) < 1
            -c / 2 * (Math.sqrt(1 - t * t) - 1) + b
        else 
            c / 2 * (Math.sqrt(1 - (t -= 2) * t) + 1) + b

    easeInElastic: (t, b, c, d) ->
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

    easeOutElastic: (t, b, c, d) ->
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

    easeInOutElastic: (t, b, c, d) ->
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