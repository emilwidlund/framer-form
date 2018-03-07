class exports.FBX
    constructor: (properties, cb) ->
        @modelLoader = new THREE.FBXLoader
        @modelLoader.load properties.path, (model) =>
            cb model
        , null, (e) -> console.log e