require './lib/GPUParticleSystem.js'

_ = Framer._

{BaseClass} = require './_BaseClass.coffee'
{Animation} = require './_Animation.coffee'
{States} = require './_States.coffee'

class exports.ParticleSystem extends BaseClass
    constructor: (properties={}) ->
        super()

        _.defaults properties,
            position: new THREE.Vector3()
            positionRandomness: .3
            velocity: new THREE.Vector3()
            velocityRandomness: .5
            color: 0xaa88ff
            colorRandomness: .2
            turbulence: .5
            lifetime: 2
            size: 5
            sizeRandomness: 1
            spawnRate: 15000
            horizontalSpeed: 1.5
            verticalSpeed: 1.33
            timeScale: 1
            particleNoiseTexture: './modules/form/lib/textures/perlin-512.png'
            particleSpriteTexture: './modules/form/lib/textures/particle2.png'

        @properties = properties

        @clock = new THREE.Clock
        @tick = 0
        @textureLoader = new THREE.TextureLoader()

        @particleSystem = new THREE.GPUParticleSystem
            maxParticles: 250000
            particleNoiseTex: @textureLoader.load properties.particleNoiseTexture
            particleSpriteTex: @textureLoader.load properties.particleSpriteTexture

        @addToRenderingInstance properties.parent

        Framer.CurrentContext.on 'reset', =>
            cancelAnimationFrame @animationLoopRequestId

        @animationLoopRequestId = requestAnimationFrame @loop

    addToRenderingInstance: (parent) ->
        if parent.scene then parent.scene.add @particleSystem
        else parent.add @particleSystem
    
    loop: () =>

        @animationLoopRequestId = requestAnimationFrame @loop

        delta = @clock.getDelta() * @properties.timeScale
        @tick += delta

        if @tick < 0 
            @tick = 0

        if delta > 0
            
            @properties.position.x = Math.sin( @tick * @properties.horizontalSpeed ) * 20
            @properties.position.y = Math.sin( @tick * @properties.verticalSpeed ) * 10
            @properties.position.z = Math.sin( @tick * @properties.horizontalSpeed + @properties.verticalSpeed ) * 5
            

            for [0..@properties.spawnRate * delta]
                @particleSystem.spawnParticle
                    position: @properties.position
                    positionRandomness: @properties.positionRandomness
                    velocity: @properties.velocity
                    velocityRandomness: @properties.velocityRandomness
                    color: @properties.color
                    colorRandomness: @properties.colorRandomness
                    turbulence: @properties.turbulence
                    lifetime: @properties.lifetime
                    size: @properties.size
                    sizeRandomness: @properties.sizeRandomness
                
        @particleSystem.update @tick