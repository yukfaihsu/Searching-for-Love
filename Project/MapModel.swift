class Location:CustomStringConvertible{
    let name:String
    let monster:Monster
    let hero:Hero
    
    init(name:String, monster:Monster, hero:Hero){
        self.name = name
        self.monster = monster
        self.hero = hero
    }
}
extension Location{
    var description: String{
        get{
            return self.name
        }
    }
}

class RoadModel {
    
    let src:Location
    let dest:Location
    let roadType:RoadType
    
    init(_ src:Location, _ dest:Location, _ roadType:RoadType){
        self.src = src
        self.dest = dest
        self.roadType = roadType
    }
}

enum RoadType{
    case PAVED, MOUNTAINOUS, SWAMPY
}
