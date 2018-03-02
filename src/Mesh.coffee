_ = Framer._

class exports.Mesh extends THREE.Mesh
    constructor: (properties={}) ->
        super properties.geometry, properties.material

        if properties.parent
            if properties.parent.scene then properties.parent.scene.add @
            else properties.parent.add @
        

        # POSITION

        @position.x = properties.x || 0
        @position.y = properties.y || 0
        @position.z = properties.z || 0

    on: (eventName, cb) ->
        @addEventListener eventName, cb
