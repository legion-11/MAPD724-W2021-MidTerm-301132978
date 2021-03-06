import SpriteKit
import GameplayKit

class Plane: GameObject
{
    
    // constructor
    init()
    {
        super.init(imageString: "plane", initialScale: 2.0)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // initialization
    override func Start()
    {
        zPosition = 2
        position = CGPoint(x: 0, y: -495)
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
