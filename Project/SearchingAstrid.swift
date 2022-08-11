class SearchingAstrid {
    
    func traverse(_ roads:[RoadModel], _ hugieLocation:Location, _ astridLocation:Location) -> [Location] {
        
        var roadToAstrid:[Location] = [hugieLocation]
        var currentLocation:Location = hugieLocation
        var lastLocationWithMultipleDest:[Location] = []
        var visitedLocations:[String] = []
        
        print("Starting the search for Astrid")
        
        if(hugieLocation.name == astridLocation.name){
            print("\tSearching \(currentLocation): Astrid Found!\n")
            print("Astrid is in \(currentLocation)\n")
            return roadToAstrid
        } else {
            print("\tSearching \(currentLocation): Astrid not Found!")
        }
        
        repeat {
            var roadsLeadingCount:Int = 0
            
            for road in roads {
                if (road.src.name == currentLocation.name && !visitedLocations.contains(road.dest.name)){
                    roadsLeadingCount += 1
                }
            }
            if (roadsLeadingCount == 0){
                if (lastLocationWithMultipleDest.isEmpty){
                    print("\tCouldn't find Astrid anywhere!\n")
                    roadToAstrid.removeAll()
                    return roadToAstrid
                } else {
                    currentLocation = lastLocationWithMultipleDest.last!
                    lastLocationWithMultipleDest.removeLast()
                    while(roadToAstrid.last!.name != currentLocation.name){
                        roadToAstrid.removeLast()
                    }
                }
            }
            else if (roadsLeadingCount == 1){
                for road in roads {
                    if (road.src.name == currentLocation.name && !visitedLocations.contains(road.dest.name)){
                        currentLocation = road.dest
                        roadToAstrid.append(road.dest)
                        visitedLocations.append(road.dest.name)
                        if (currentLocation.name == astridLocation.name){
                            print("\tSearching \(currentLocation): Astrid Found!\n")
                            print("Astrid is in \(currentLocation)\n")
                            return roadToAstrid
                        }
                        print("\tSearching \(currentLocation): Astrid not Found!")
                        break
                    }
                }
            }
            else if (roadsLeadingCount > 1){
                var roadsLeadingTo:[RoadModel] = []
                for road in roads {
                    if (road.src.name == currentLocation.name && !visitedLocations.contains(road.dest.name)){
                        roadsLeadingTo.append(road)
                    }
                }
                if(roadsLeadingTo.count > 1){
                    lastLocationWithMultipleDest.append(getPath(roadsLeadingTo).src)
                }
                visitedLocations.append(getPath(roadsLeadingTo).dest.name)
                currentLocation = getPath(roadsLeadingTo).dest
                roadToAstrid.append(getPath(roadsLeadingTo).dest)
                if (currentLocation.name == astridLocation.name){
                    print("\tSearching \(currentLocation): Astrid Found!\n")
                    print("Astrid is in \(currentLocation)\n")
                    return roadToAstrid
                }
                print("\tSearching \(currentLocation): Astrid not Found!")
            }
        } while(true)
    }
    
    func getPath(_ roadsLeadingTo:[RoadModel]) -> RoadModel {
        
        let betaHero = Hero(name: "", maxHP: 0, weaponStrength: 0)
        let betaMonster = Monster(name: "", maxHP: 0, attackPower: 0)
        let betaLocation = Location(name: "", monster: betaMonster, hero:betaHero)
        
        var chosenPath:RoadModel = RoadModel(betaLocation, betaLocation, RoadType.PAVED)
        
        
        for road in roadsLeadingTo {
            if (road.roadType == RoadType.PAVED){
                chosenPath = road
                break
            }
            if (road.roadType == RoadType.SWAMPY && chosenPath.roadType != RoadType.SWAMPY){
                chosenPath = road
            }
            if (road.roadType == RoadType.MOUNTAINOUS && chosenPath.roadType != RoadType.SWAMPY && chosenPath.roadType != RoadType.MOUNTAINOUS){
                chosenPath = road
            }
        }
        return chosenPath
    }
    
    func takeJourney(_ roadToAstrid:[Location]) {
        
        print("Generating the easiest path to Astrid....")
        print("Path found. The easiest path to Astrid is: \(roadToAstrid)")
        
        for location in roadToAstrid {
            
            print("Hugie arrives at \(location)")
            
            let fighting = Fight(hero: location.hero, monster: location.monster)
            fighting.battle()
            if (fighting.gameOver) {
                return
            }
            
            if (location.name == roadToAstrid.last!.name){
                // found Astrid code
                print("Hugie Rescues Astrid, Player wins! Game over!\n")
            }
        }
    }
}
