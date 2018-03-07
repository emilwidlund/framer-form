class exports.GLTF
    constructor: (properties, cb) ->
        @modelLoader = new THREE.GLTFLoader
        @modelLoader.load properties.path, (model) ->
            cb model