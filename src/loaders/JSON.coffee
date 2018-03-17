class exports.JSON
    constructor: (properties, cb) ->

        @modelLoader = new THREE.ObjectLoader
        @modelLoader.load properties.path, (model) =>
            cb model
        , null, (e) console.log e