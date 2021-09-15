import UIKit

struct Player{
    var playerID:String
    var champ:Champion
    var firstSpell:Spell
    var secondSpell:Spell
    
    init(){
        self.playerID = "NIL"
        self.champ = Champion(championName: "NIL_CHAMP", championURL: URL(fileURLWithPath: "NIL_PATH"))
        self.firstSpell = Spell()
        self.secondSpell = Spell()
    }
    
    init(playerID: String, champ:Champion, firstSpell: Spell, secondSpell: Spell) {
        self.playerID = playerID
        self.champ = champ
        self.firstSpell = firstSpell
        self.secondSpell = secondSpell
    }
}


