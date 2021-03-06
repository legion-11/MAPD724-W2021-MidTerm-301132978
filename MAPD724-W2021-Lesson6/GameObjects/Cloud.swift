import SpriteKit
import GameplayKit

class Cloud: GameObject
{
    
    // constructor
    init(_ isPortrait: Bool)
    {
        super.init(imageString: "cloud", initialScale: 1.0)
        Start(isPortrait: isPortrait)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // initialization
    override func Start(isPortrait: Bool)
    {
        zPosition = 3
        alpha = 0.5
        if isPortrait {
            Reset()
        } else {
            ResetLandscape()
            Rotate(isPortrait: isPortrait)
        }
    }
    
    override func Rotate(isPortrait: Bool)
    {
        super.Rotate(isPortrait: isPortrait)
        let tmp = dx
        dx = (isPortrait) ? 0 - dy! : dy
        dy = (isPortrait) ? tmp: 0 - tmp!
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
        position.x -= dx!
    }
    
    override func CheckBounds()
    {
        if(position.y <= -756)
        {
            Reset()
        }
    }
    
    override func Reset()
    {
        dy = CGFloat((randomSource?.nextUniform())! * 5.0) + 5.0
        dx = CGFloat((randomSource?.nextUniform())! * -4.0) + 2.0
        
        // get a pseudo-random number from -262 to 262 =
        let randomX:Int = (randomSource?.nextInt(upperBound: 524))! - 262
        position.x = CGFloat(randomX)
        
        let randomY:Int = (randomSource?.nextInt(upperBound: 10))! + 756
        position.y = CGFloat(randomY)
        
        isColliding = false
    }
    
    override func UpdateLandscape()
    {
        MoveLandscape()
        CheckBoundsLandscape()
    }
    
    func MoveLandscape()
    {
        position.y -= dy!
        position.x -= dx!
    }
    
    override func CheckBoundsLandscape()
    {
        if(position.x <= -756)
        {
            ResetLandscape()
        }
    }
    
    override func ResetLandscape()
    {
        dx = CGFloat((randomSource?.nextUniform())! * 5.0) + 5.0
        dy = CGFloat((randomSource?.nextUniform())! * -4.0) + 2.0
        
        // get a pseudo-random number from -262 to 262 =
        let randomX:Int = (randomSource?.nextInt(upperBound: 10))! + 756
        position.x = CGFloat(randomX)
        
        let randomY:Int = (randomSource?.nextInt(upperBound: 524))! - 262
        position.y = CGFloat(randomY)
        
        isColliding = false
    }
}
