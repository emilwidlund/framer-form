require '../lib/OBJLoader.js'
{Mesh} = require './Mesh.coffee'

exports.Import = (properties={}, callback) ->
    objLoader = new THREE.OBJLoader
    objLoader.load properties.path, (obj) =>

        obj.__proto__.on = (eventName, cb) ->
            @traverse (child) ->
                if child instanceof THREE.Mesh
                    child.addEventListener eventName, cb

        obj.traverse (child) ->
            if child instanceof THREE.Mesh
                child.material = properties.material

        obj.scale.set(
            properties.scale || 1
            properties.scale || 1
            properties.scale || 1
        )

        if properties.parent
            if properties.parent.scene then properties.parent.scene.add obj
            else properties.parent.add obj
        
        obj.position.x = properties.x || 0
        obj.position.y = properties.y || 0
        obj.position.z = properties.z || 0
        
        obj.rotation.x = properties.rotationX || 0
        obj.rotation.y = properties.rotationY || 0
        obj.rotation.z = properties.rotationZ || 0

        callback(obj)