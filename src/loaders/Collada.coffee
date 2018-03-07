require '../lib/ColladaLoader.js'

class exports.Collada
    constructor: (properties, cb) ->
        @modelLoader = new THREE.ColladaLoader
        @modelLoader.load properties.path, (collada) =>
            collada.scene.animations = collada.animations
            cb collada.scene
        , null, (e) -> console.log e