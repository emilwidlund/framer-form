class exports.BaseClass

    @define = (propertyName, descriptor) ->
        if descriptor.readonly
            descriptor.set = (value) ->
                throw Error("#{@constructor.name}.#{propertyName} is readonly")

        Object.defineProperty(@prototype, propertyName, descriptor)