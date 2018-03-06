_ = Framer._

{Model} = require './Model.coffee'

class exports.Animation extends Framer.EventEmitter
    constructor: (model, properties={}) ->
        super()

        if !properties
            throw new Error 'Please specify properties or a state to animate!'
        
        if _.isString properties
            properties = model.states[properties]

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

        if @deltas.length
            Utils.delay @options.delay, =>
                @intervalDisposer = setInterval () => 
                    if @renderedFrames >= @totalFrames
                        return @disposeInterval

                    requestAnimationFrame @animationLoop
                    
                    @renderedFrames++
                , 1000 / @fps
    
    filterProperties: (properties) ->
        props = Object.assign {}, properties
        delete props.options
        props

    calculateDeltas: () ->
        deltas = Object.keys(@properties).map (k) =>
            if @model[k] > @properties[k]
                {[k]: -Math.abs(@model[k] - @properties[k])}
            else if @model[k] < @properties[k]
                {[k]: Math.abs(@model[k] - @properties[k])}
            else
                null
        
        deltas.filter (d) ->
            d


    animationLoop: () =>
        for delta, i in @deltas
            @model[Object.keys(delta)[0]] += Object.values(delta)[0] / (@time * @fps)

    disposeInterval: () ->
        clearInterval @intervalDisposer