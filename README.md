# TransitApp

App developed using MVC architecture due to project simplicity.

Station details available when cell is clicked.

Distance colors in table view are chosen as it follows:

```swift
switch vehicleType {
        case vehicleTypes.lightRail.rawValue:
            color = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        case vehicleTypes.heavyRail.rawValue:
            color = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        case vehicleTypes.comuterRail.rawValue:
            color = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        case vehicleTypes.bus.rawValue:
            color = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        case vehicleTypes.ferry.rawValue:
            color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        default:
            color = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
```
