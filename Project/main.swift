mainMenu()

func mainMenu() {
    
    var hasSearchedAstrid:Bool = false
    var roadToAstrid:[Location] = []

    repeat {
        let h1 = Hero(name: "Hugie", maxHP: 190, weaponStrength: 12)
        let m1 = Monster(name: "Thunder", maxHP: 22, attackPower: 5)
        let m2 = Monster(name: "Storm", maxHP: 32, attackPower: 7)
        let m3 = Monster(name: "Hurrican", maxHP: 44, attackPower: 9)
        let m4 = Monster(name: "Blizzard", maxHP: 50, attackPower: 10)
        let m5 = Monster(name: "Typhoon", maxHP: 55, attackPower: 12)
        let m6 = Monster(name: "Final Boss", maxHP: 60, attackPower: 13)

        let Ithaca = Location(name: "Ithaca", monster: m1, hero:h1)
                let Argos = Location(name: "Argos", monster: m2, hero:h1)
                let Salamis = Location(name: "Salamis", monster: m3, hero:h1)
                let Mycanae = Location(name: "Mycanae", monster: m4, hero:h1)
                let Sparta = Location(name: "Sparta", monster: m5, hero:h1)
                let Athens = Location(name: "Athens", monster: m6, hero:h1)
                

                var roads = [RoadModel]()

                roads += [RoadModel(Ithaca, Argos, RoadType.MOUNTAINOUS),
                          RoadModel(Ithaca, Mycanae, RoadType.PAVED),
                          RoadModel(Ithaca, Sparta, RoadType.SWAMPY),
                          RoadModel(Argos, Salamis, RoadType.PAVED),
                          RoadModel(Mycanae, Salamis, RoadType.MOUNTAINOUS),
                          RoadModel(Sparta, Athens, RoadType.PAVED),
                          RoadModel(Salamis, Athens, RoadType.PAVED)]
        
        let hugieLocation:Location = Ithaca
        let astridLocation:Location = Athens

        let searchingAstrid = SearchingAstrid()

        print("Welcome to Search for Love")
        print("What will you do")
        if !hasSearchedAstrid{
            print("1. Search for Astrid")
        }
        else{
            print("1. Search for Astrid [COMPLETED!]")
        }
        print("2. Rescue Astrid")
        print("3. Quit")
        
        let input = readLine()
        
        if let input = input {
            switch(input){
            case "1":
                if (!hasSearchedAstrid){
                    roadToAstrid = searchingAstrid.traverse(roads, hugieLocation, astridLocation)
                    hasSearchedAstrid = true
                    if(roadToAstrid.isEmpty){
                        print("Hugie CANNOT rescue Astrid")
                        print("************ Game Over ************\n")
                    }
                }
                else{
                    print("You have already searched for Astrid, GO RESCUE HER!\n")
                }
            case "2":
                if(hasSearchedAstrid){
                    searchingAstrid.takeJourney(roadToAstrid)
                    roadToAstrid.removeAll()
                    hasSearchedAstrid = false
                }
                else{
                    print("You need to search for Astrid before rescuing her\n")
                }
            case "3":
                print("Thank you for playing, GoodBye!")
                return
            default:
                print("Please enter a valid option.\n")
            }
        }
    } while(true)
}
