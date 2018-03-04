_ = Framer._

{Model} = require './Model.coffee'

class exports.Animation extends Framer.EventEmitter
    constructor: (mesh, properties={}) ->
        super()

        if !properties
            throw new Error 'Please specify a property to animate!'

        @mesh = mesh
        @properties = @filterProperties properties
        @options = _.defaults properties.options, 
            time: 1
            delay: 0

        @fps = 60
        @time = @options.time
        @renderedFrames = 0
        @totalFrames = @time * @fps

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

    animationLoop: () =>
        for k, i in Object.keys @properties

            # Small hack to handle scaling animations
            if k.x then k == 'scale'

            if @properties[k] < @mesh[k] || @properties[k] < @mesh[k].x
                delta = @mesh[k] - @properties[k]
                if k.includes 'rotation'
                    @mesh.mesh.rotation[k.slice(-1).toLowerCase()] -= THREE.Math.degToRad(@properties[k] / (@time * @fps))
                else if k == 'scale'
                    delta = @mesh[k].x - @properties[k]
                    @mesh[k] = @mesh[k].x - Math.abs delta / (@time * @fps)
                else
                    @mesh[k] = @mesh[k] - Math.abs delta / (@time * @fps)

            if @properties[k] > @mesh[k] || @properties[k] > @mesh[k].x
                delta = @properties[k] - @mesh[k]
                if k.includes 'rotation'
                    @mesh.mesh.rotation[k.slice(-1).toLowerCase()] += THREE.Math.degToRad(@properties[k] / (@time * @fps))
                else if k == 'scale'
                    delta = @properties[k] - @mesh[k].x
                    @mesh[k] = @mesh[k].x + Math.abs delta / (@time * @fps)
                else
                    @mesh[k] = @mesh[k] + Math.abs delta / (@time * @fps)

    disposeInterval: () ->
        clearInterval @intervalDisposer