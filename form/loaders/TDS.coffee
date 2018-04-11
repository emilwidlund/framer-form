require '../lib/TDSLoader.js'

class exports.TDS
    constructor: (properties, cb) ->
        @modelLoader = new THREE.TDSLoader
        @modelLoader.load properties.path, (model) =>
            cb model
        , null, (e) -> console.log e