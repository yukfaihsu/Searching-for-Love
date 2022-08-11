class GameCharacter:CustomStringConvertible{

    let name:String
    var maxHP:Int
    var currHP:Int
    
    init(name:String, maxHP:Int){
        self.name = name
        self.maxHP = maxHP
        self.currHP = maxHP
    }
    
    func takeDamage(amt:Int){
        self.currHP = self.currHP - amt
    }
}

extension GameCharacter{
    var description: String{
        get{
            if currHP < 0{
                return "\(name) HP: 0/\(maxHP)"
            }
            else{
                return "\(name) HP: \(currHP)/\(maxHP)"
            }
        }
    }
}

class Hero:GameCharacter{
    
    let weaponStrength:Int
    
    init(name: String, maxHP: Int, weaponStrength: Int) {
        self.weaponStrength = weaponStrength
        super.init(name: name, maxHP: maxHP)
    }
    
    func attack() -> Int {
        let criticalProb:Int = Int.random(in: 1...10)
        var currAttackPoint:Int = weaponStrength
        if criticalProb <= 3{
            currAttackPoint = Int(Double(weaponStrength) * 1.2)
        }
        print("\n*** \(name) attacks: \(currAttackPoint) damage!")
        if criticalProb <= 3{
            print("*** CRITICAL HIT!")
        }
        return currAttackPoint
    }
}

class Monster:GameCharacter{
    
    let attackPower:Int
    
    init(name: String, maxHP: Int, attackPower: Int) {
        self.attackPower = attackPower
        super.init(name: name, maxHP: maxHP)
    }
    
    func attack() -> Int {
        let missProb:Int = Int.random(in: 1...10)
        var currAttackPoint:Int = attackPower
        if missProb <= 2{
            currAttackPoint = 0
        }
        print("\n*** \(name) attacks: \(currAttackPoint) damage!")
        if missProb <= 2{
            print("*** \(name) MISSED!")
        }
        return currAttackPoint
    }
}
