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

        # ROTATION

        @rotation.x = THREE.Math.degToRad(properties.rotationX) || 0
        @rotation.y = THREE.Math.degToRad(properties.rotationY) || 0
        @rotation.z = THREE.Math.degToRad(properties.rotationZ) || 0



    animate: (properties) ->
        console.log properties

        framesRendered = 0
        framesTotal = properties.options.time * 60

        animation = () =>
            @rotation.y += THREE.Math.degToRad(properties.rotationY / (properties.options.time * 60))

        intervalDisposer = setInterval () -> 
            if framesRendered >= framesTotal
                return clearInterval intervalDisposer
            requestAnimationFrame animation
            framesRendered++
        , 1000 / 60 



    on: (eventName, cb) ->
        @addEventListener eventName, cb