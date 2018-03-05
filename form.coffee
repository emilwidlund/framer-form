window.THREE = require './lib/three.min.js'
window.Form = window.THREE

{Scene} = require './src/Scene.coffee'
{Studio} = require './src/Studio.coffee'
{Mesh} = require './src/Mesh.coffee'
{Model} = require './src/Model.coffee'

module.exports =
    Scene: Scene
    Studio: Studio
    Mesh: Mesh
    Model: Model