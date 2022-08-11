class Fight{
    
    let hero:Hero
    let monster:Monster
    var turn:Int
    var fightOver:Bool
    var gameOver:Bool
    
    init(hero:Hero, monster:Monster){
        self.hero = hero
        self.monster = monster
        self.turn = 1
        self.fightOver = false
        self.gameOver = false
    }

    private func applyDamage(gameChar1:GameCharacter, gameChar2:GameCharacter){
        if let hero = gameChar1 as? Hero{
            gameChar2.takeDamage(amt: hero.attack())
        }
        else if let monster = gameChar1 as? Monster{
            gameChar2.takeDamage(amt: monster.attack())
        }
    }
    
    func performTurn(move:Moves){
        var lose = false
        switch(move){
        case Moves.HEROATTACK:
            applyDamage(gameChar1: hero, gameChar2: monster)
            print("*** \(monster)")
            if monster.currHP <= 0{
                fightOver = true
                print("")
                print("Fight is over")
                print("\(hero.name) wins")
            }
        case Moves.MONSTERATTACK:
            applyDamage(gameChar1: monster, gameChar2: hero)
            print("*** \(hero)")
            if hero.currHP <= 0{
                fightOver = true
                lose = true
                print("")
                print("Fight is over")
                print("\(monster.name) wins")
            }
        case Moves.SNEAK:
            print("\n*** \(hero.name) is sneaking")
            let sneakProb = Int.random(in: 1...10)
            if sneakProb <= 3{
                fightOver = true
                print("*** \(hero.name) successfully sneaked pass \(monster.name)!")
                print("")
                print("Fight is over")
                print("\(hero.name) wins")
            }
            else{
                print("*** \(hero.name) fails the sneaking")
            }
        case Moves.RUNAWAY:
            fightOver = true
            lose = true
            print("\n*** \(hero.name) runs away")
            print("")
            print("Fight is over")
            print("\(monster.name) wins")
        }
        if fightOver{
            print("\nFinal Stats:")
            print("\t\(hero)")
            print("\t\(monster)\n")
        }
        
        if lose{
            print("Hugie CANNOT rescue Astrid")
            print("************ Game Over ************\n")
            gameOver = true
        }
        turn += 1
    }
    
    func battle(){
        print("\(monster.name) is waiting to fight!")
        print("Fight begins!")
        repeat{
            print("\n-------- Turn #: \(turn) --------")

            var moveThisTurn:Moves = Moves.MONSTERATTACK

            if turn%2 != 0{
                print("Current Turn is: \(hero.name)")
            }
            else{
                print("Current Turn is: \(monster.name)")
            }
            print(hero)
            print(monster)

            if turn%2 != 0{
                var invalidInput = true
                
                repeat{
                    print("\n\(hero.name), what move will you make?")
                    print("1. Attack")
                    print("2. Sneak")
                    print("3. Give Up")
                    print("Enter choice:", terminator: " ")
                
                    let input = readLine()!
                    switch(input){
                    case "1":
                        moveThisTurn = Moves.HEROATTACK
                        invalidInput = false
                    case "2":
                        moveThisTurn = Moves.SNEAK
                        invalidInput = false
                    case "3":
                        moveThisTurn = Moves.RUNAWAY
                        invalidInput = false
                    default:
                        print("\nInvalid selection, please try again.")
                    }
                } while (invalidInput)
            }
            performTurn(move: moveThisTurn)

        }while(!fightOver)
    }
}

enum Moves{
    case HEROATTACK, MONSTERATTACK, SNEAK, RUNAWAY
}
