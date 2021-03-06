import SpriteKit
import GameplayKit

class Island: GameObject
{
    
    // constructor
    init(_ isPortrait: Bool)
    {
        super.init(imageString: "island", initialScale: 2.0)
        Start(isPortrait: isPortrait)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // initialization
    override func Start(isPortrait: Bool)
    {
        zPosition = 1
        if isPortrait {
            Reset()
        } else {
            Rotate(isPortrait: isPortrait)
            ResetLandscape()
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
        if(position.y <= -730)
        {
            Reset()
        }
    }
    
    override func Reset()
    {
        position.y = 730
        // get a pseudo-random number from -313 to 313 =
        let randomX:Int = (randomSource?.nextInt(upperBound: 626))! - 313
        position.x = CGFloat(randomX)
        isColliding = false
    }
    
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
        if(position.x <= -730)
        {
            ResetLandscape()
        }
    }
    
    override func ResetLandscape()
    {
        position.x = 730
        // get a pseudo-random number from -313 to 313 =
        let randomX:Int = (randomSource?.nextInt(upperBound: 626))! - 313
        position.y = CGFloat(randomX)
        isColliding = false
    }
    
}
