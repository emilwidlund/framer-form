{BaseClass} = require './BaseClass.coffee'

acceptedModelProperties = [
    'x'
    'y'
    'z'
    'rotationX'
    'rotationY'
    'rotationZ'
    'scale'
    'options'
]

class exports.States extends BaseClass
    constructor: (model) ->
        super()

        @model = model
        @mesh = @model.mesh
        @pivot = @model.pivot

        @initialModelProperties = Object.getOwnPropertyNames Object.getPrototypeOf @model.initialProperties

        @states = 
            default: @filterProperties @initialModelProperties
            initial: @filterProperties @initialModelProperties

    filterProperties: (propeties) ->
        newPropertyObj = {}
        propeties.map (k) =>
            if acceptedModelProperties.includes k
                newPropertyObj[k] = @model[k]
        return newPropertyObj
    
