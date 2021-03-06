import SpriteKit
import GameplayKit

class Ocean: GameObject
{
    
    // constructor
    init(_ isPortrait: Bool)
    {
        super.init(imageString: "ocean", initialScale: 2.0)
        Start(isPortrait: isPortrait)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // initialization
    override func Start(isPortrait: Bool)
    {
        zPosition = 0
        position = CGPoint(x: 0, y: 773)
        if (!isPortrait) {Rotate(isPortrait: isPortrait)
}
        dy = 5.0
        dx = 5.0
    }
    
    
    override func Rotate(isPortrait: Bool)
    {
        position = (isPortrait) ? CGPoint(x: 0 - position.y, y: position.x) : CGPoint(x: position.y, y: 0 - position.x)
        zRotation = isPortrait ? 0 : 0 - (.pi / 2)
    }
    
    // LifeCycle Functions
    override func Update()
    {
        Move()
        CheckBounds()
    }
    
    func Move()
    {
        position.y -= dy!
    }
    
    override func CheckBounds()
    {
        if(position.y <= -773)
        {
            Reset()
        }
    }
    
    override func Reset()
    {
        position.y = 773
    }
    
    // LifeCycle Functions
    override func UpdateLandscape()
    {
        MoveLandscape()
        CheckBoundsLandscape()
    }
    
    func MoveLandscape()
    {
        position.x -= dx!
    }
    
    override func CheckBoundsLandscape()
    {
        if(position.x <= -773)
        {
            ResetLandscape()
        }
    }
    
    override func ResetLandscape()
    {
        position.x = 773
    }
}
