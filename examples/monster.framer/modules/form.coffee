window.THREE = require './form/lib/three.min.js'
require './form/GA.coffee'

{Scene} = require './form/Scene.coffee'
{Studio} = require './form/Studio.coffee'
{Model} = require './form/Model.coffee'
{Mesh} = require './form/Mesh.coffee'
{Light} = require './form/Light.coffee'

module.exports =
    Scene: Scene
    Studio: Studio
    Model: Model
    Mesh: Mesh
    Light: Light

    # MATERIALS

    MeshPhongMaterial: THREE.MeshPhongMaterial
    MeshNormalMaterial: THREE.MeshNormalMaterial
    MeshStandardMaterial: THREE.MeshStandardMaterial
    LineBasicMaterial: THREE.LineBasicMaterial
    LineDashedMaterial: THREE.LineDashedMaterial
    MeshBasicMaterial: THREE.MeshBasicMaterial
    MeshDepthMaterial: THREE.MeshDepthMaterial
    MeshLambertMaterial: THREE.MeshLambertMaterial
    MeshPhysicalMaterial: THREE.MeshPhysicalMaterial
    MeshToonMaterial: THREE.MeshToonMaterial
    PointsMaterial: THREE.PointsMaterial
    RawShaderMaterial: THREE.RawShaderMaterial
    ShaderMaterial: THREE.ShaderMaterial
    ShadowMaterial: THREE.ShadowMaterial
    SpriteMaterial: THREE.SpriteMaterial