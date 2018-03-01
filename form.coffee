window.THREE = require './lib/three.min.js'
window.Form = window.THREE

{Scene} = require './src/Scene.coffee'
{Mesh} = require './src/Mesh.coffee'
{importModel} = require './src/importModel.coffee'

module.exports =
    Scene: Scene
    Mesh: Mesh
    importModel: importModel