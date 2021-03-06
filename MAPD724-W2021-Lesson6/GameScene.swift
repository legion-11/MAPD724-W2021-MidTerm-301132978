import UIKit
import AVFoundation
import SpriteKit
import GameplayKit

let screenSize = UIScreen.main.bounds
var screenWidth: CGFloat?
var screenHeight: CGFloat?

// implements CanReceiveTransitionEvents protocol to change object orientations and scene size
class GameScene: SKScene, CanReceiveTransitionEvents
{
    
    // instance variables
    var ocean: Ocean?
    var island: Island?
    var plane: Plane?
    var clouds: [Cloud] = []
    var isPortraitOrientation = true
    override func didMove(to view: SKView)
    {
        screenWidth = frame.width
        screenHeight = frame.height
        isPortraitOrientation = isPortrait()
        name = "GAME"
        
        ocean = Ocean(isPortraitOrientation) // allocate memory
        plane = Plane(isPortraitOrientation)
        island = Island(isPortraitOrientation)
        for _ in 0...1
        {
            let cloud: Cloud = Cloud(isPortraitOrientation)
            clouds.append(cloud)
        }
        
        addChild(ocean!) // add object to the scene
        addChild(plane!) // add plane to the scene
        addChild(island!) // add island to the scene
        // add 2 clouds to the scene
        for cloud in clouds
        {
            addChild(cloud)
        }
        
        let engineSound = SKAudioNode(fileNamed: "engine.mp3")
        self.addChild(engineSound)
        engineSound.autoplayLooped = true
        
        // preload sounds
        do {
            let sounds:[String] = ["thunder", "yay"]
            for sound in sounds
            {
                let path: String = Bundle.main.path(forResource: sound, ofType: "mp3")!
                let url: URL = URL(fileURLWithPath: path)
	                let player: AVAudioPlayer = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
            }
        } catch {
        }
        
    }
    
    // returns true if the device orientation is portrait
    func isPortrait() -> Bool {
        return (UIApplication.shared.windows
                .first?
                .windowScene?
                .interfaceOrientation
                .isPortrait) ?? true
    }
    
    func movePlane(atPoint pos : CGPoint) {
        if (isPortrait())
        {
            plane?.TouchMove(newPos: CGPoint(x: pos.x, y: -495))
        } else {
            plane?.TouchMove(newPos: CGPoint(x: -495, y: pos.y))
        }
    }
    
    func touchDown(atPoint pos : CGPoint)
    {
        movePlane(atPoint: pos)
    }
    
    func touchMoved(toPoint pos : CGPoint)
    {
        movePlane(atPoint: pos)
    }
    
    func touchUp(atPoint pos : CGPoint)
    {
        movePlane(atPoint: pos)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    // this is where all the fun happens - this function is called about 60fps - every 16.666ms
    override func update(_ currentTime: TimeInterval)
    {
        // depending on orientation objects updates with different functions,
        // so we have only one global check of orientation 
        if (isPortraitOrientation) {
            ocean?.Update()
            island?.Update()
            plane?.Update()
            
            for cloud in clouds
            {
                cloud.Update()
            }
        } else {
            ocean?.UpdateLandscape()
            island?.UpdateLandscape()
            plane?.UpdateLandscape()
            
            for cloud in clouds
            {
                cloud.UpdateLandscape()
            }
        }
        // we do not need to change the colision to check with half width in landscape as a radius of object since we rotated objects
        CollisionManager.SquaredRadiusCheck(scene: self, object1: plane!, object2: island!)
        for cloud in clouds
        {
            CollisionManager.SquaredRadiusCheck(scene: self, object1: plane!, object2: cloud)
        }
        
    }
    
    // this method will be called when a change in screen size occurs
    func viewDidTransition()
    {
        let willBePortrait = isPortrait()
        // if screen changed orientation from landscape to portrait or vice versa
        if willBePortrait != isPortraitOrientation {
            size = CGSize(width: size.height, height: size.width)
            screenWidth = frame.width
            screenHeight = frame.height
            ocean?.Rotate(isPortrait: willBePortrait)
            plane?.Rotate(isPortrait: willBePortrait)
            island?.Rotate(isPortrait: willBePortrait)
            for cloud in clouds
            {
                cloud.Rotate(isPortrait: willBePortrait)
            }
            
        }
        isPortraitOrientation = willBePortrait
    }
}
