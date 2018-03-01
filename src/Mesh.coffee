_ = Framer._

class exports.Mesh extends THREE.Mesh
    constructor: (properties={}) ->
        super properties.geometry, properties.material
        properties.parent.scene.add @
        

        # POSITION

        @position.x = properties.x || 0
        @position.y = properties.y || 0
        @position.z = properties.z || 0

    on: (eventName, cb) ->
        @addEventListener eventName, ->
            cb()
