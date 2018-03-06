{BaseClass} = require './BaseClass.coffee'

acceptedModelProperties = [
    'x'
    'y'
    'z'
    'rotationX'
    'rotationY'
    'rotationZ'
    'scale'
    'scaleX'
    'scaleY'
    'scaleZ'
]

class exports.States extends BaseClass
    constructor: (model) ->
        super()

        @model = model
        @mesh = @model.mesh
        @pivot = @model.pivot

        @modelPropertiesFromPrototype = Object.getOwnPropertyNames Object.getPrototypeOf @model

        @stateObjects = 
            default: @filterProperties @modelPropertiesFromPrototype
            initial: @filterProperties @modelPropertiesFromPrototype

    filterProperties: (propeties) ->
        newPropertyObj = {}
        propeties.map (k) =>
            if acceptedModelProperties.includes k
                newPropertyObj[k] = @model[k]
        return newPropertyObj

    
    @define 'states',
        get: -> @stateObjects
    
