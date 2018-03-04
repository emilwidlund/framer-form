window.THREE = require './lib/three.min.js'
window.Form = window.THREE

{Scene} = require './src/Scene.coffee'
{Mesh} = require './src/Mesh.coffee'
{Model} = require './src/Model.coffee'

module.exports =
    Scene: Scene
    Mesh: Mesh
    Model: Model