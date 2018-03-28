_ = Framer._

{Camera} = require './_Camera.coffee'

class exports.Scene extends Layer
    constructor: (properties={}) ->
        super _.defaults properties,
            backgroundColor: '#000'

        # RENDERER
        
        @renderer = new THREE.WebGLRenderer
            antialias: true
            alpha: true
        
        @_element.appendChild @renderer.domElement
        @renderer.setSize @width, @height
        @renderer.setPixelRatio window.devicePixelRatio
        @renderer.domElement.style.width = '100%'
        @renderer.domElement.style.height = '100%'
        @renderer.shadowMap.enabled = true
        @renderer.shadowMap.type = THREE.PCFSoftShadowMap


        # SCENE

        @scene = new THREE.Scene


        # CAMERA

        cameraProps = _.defaults properties.camera,
            aspect: properties.width / properties.height

        @camera = new Camera cameraProps, @._element


        # RESIZING

        Canvas.onResize @onWindowResize


        # RAYCASTER

        @raycaster = new THREE.Raycaster
        @mouse = new THREE.Vector2
        @intersected = null
        @intersectedEventEmitted = false
        @mousedown = false
        
        @on 'mousemove', (e) =>
            @mouse.x = (e.clientX / @width) * 2 - 1
            @mouse.y = -(e.clientY / @height) * 2 + 1

        @on 'mousedown', (e) =>
            @mousedown = true
            if @intersected
                @intersected.object.dispatchEvent {type: 'mousedown'}
                @intersected.object.dispatchEvent {type: 'onmousedown'}
                @intersected.object.dispatchEvent {type: 'click'}
                @intersected.object.dispatchEvent {type: 'onclick'}
        
        @on 'mouseup', (e) =>
            @mousedown = false
            if @intersected
                @intersected.object.dispatchEvent {type: 'mouseup'}
                @intersected.object.dispatchEvent {type: 'onmouseup'}


        # ANIMATION LOOP

        @loop()

        Framer.CurrentContext.on 'reset', =>
            cancelAnimationFrame @animationLoopRequestId



    loop: () =>
        @animationLoopRequestId = requestAnimationFrame @loop

        if @animationLoop
            @animationLoop()

        if @camera.controls
            @camera.controls.update()

        @handleRaycaster()

        @renderer.render @scene, @camera.nativeCamera
    

    
    handleRaycaster: () =>
        @raycaster.setFromCamera @mouse, @camera.nativeCamera
        intersects = @raycaster.intersectObjects @scene.children, true

        if intersects.length && @intersected != intersects[0]
            @intersected = intersects[0]
        
        if @intersected && !intersects.length
            @intersected.object.dispatchEvent {type: 'mouseout'}
            @intersected.object.dispatchEvent {type: 'onmouseout'}
        
        if !intersects.length
            @intersected = null
            @intersectedEventEmitted = false
        
        if !@intersectedEventEmitted && @intersected
            @intersected.object.dispatchEvent {type: 'mouseover'}
            @intersected.object.dispatchEvent {type: 'onmouseover'}
            @intersectedEventEmitted = true
    
    onWindowResize: () =>
        @width = Screen.width
        @height = Screen.height
        @camera.aspect = @width / @height
        @camera.nativeCamera.updateProjectionMatrix()

        @renderer.setSize @width, @height