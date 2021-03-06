protocol GameProtocol
{
    func Start(isPortrait: Bool)
    
    func CheckBounds()
    
    func CheckBoundsLandscape()
    
    func Reset()
    
    func ResetLandscape()
    
    func Update()
    
    func UpdateLandscape()
    
    func Rotate(isPortrait: Bool)
    
}
