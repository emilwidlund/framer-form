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

reservedStateError = (name) ->
	throw Error("The state '#{name}' is a reserved name.")

class exports.States extends BaseClass

    @defineReserved = (propertyName, descriptor) ->
        descriptor.configurable = true
        descriptor.enumerable ?= false
        descriptor.set ?= -> reservedStateError propertyName
        Object.defineProperty @prototype, propertyName, descriptor
    
    @defineReserved 'current',
        get: -> @currentState

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