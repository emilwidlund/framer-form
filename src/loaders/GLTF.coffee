require '../lib/GLTFLoader.js'

class exports.GLTF
    constructor: (properties, cb) ->
        @modelLoader = new THREE.GLTFLoader
        @modelLoader.load properties.path, (model) ->
            model.scene.animations = model.animations
            cb model.scene
        , null, (e) -> console.log e