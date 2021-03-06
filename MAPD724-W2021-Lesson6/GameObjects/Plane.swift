import SpriteKit
import GameplayKit

class Plane: GameObject
{
    
    // constructor
    init(_ isPortrait: Bool)
    {
        super.init(imageString: "plane", initialScale: 2.0)
        Start(isPortrait: isPortrait)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // initialization
    override func Start(isPortrait: Bool)
    {
        zPosition = 2
        position = CGPoint(x: 0, y: -495)
        if (!isPortrait) {Rotate(isPortrait: isPortrait)}
    }
    
    override func Rotate(isPortrait: Bool)
    {
        position = (isPortrait) ? CGPoint(x: 0 - position.y, y: position.x) : CGPoint(x: position.y, y: 0 - position.x)
        zRotation = isPortrait ? 0 : 0 - (.pi / 2)
    }
    
    // LifeCycle Functions
    override func Update()
    {
        CheckBounds()
    }
    
    override func CheckBounds()
    {
        // constrain on the left - left boundary
        if(position.x <= -310)
        {
            position.x = -310
        }
        
        // constrain on the right - right boundary
        if(position.x >= 310)
        {
            position.x = 310
        }
        
    }
    
    override func UpdateLandscape()
    {
        CheckBoundsLandscape()
    }
    
    override func CheckBoundsLandscape()
    {
        // constrain on the left - left boundary
        if(position.y <= -310)
        {
            position.y = -310
        }
        
        // constrain on the right - right boundary
        if(position.y >= 310)
        {
            position.y = 310
        }
        
    }
    
    func TouchMove(newPos: CGPoint)
    {
        position = newPos
    }
}
