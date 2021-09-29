import UIKit

struct Player{
    var playerName:String
    var champ:Champion
    var firstSpell:Spell
    var secondSpell:Spell
    
    init(){
        self.playerName = "NIL"
        self.champ = Champion(championName: "NIL_CHAMP", championKey: "NIL", championURL: URL(fileURLWithPath: "NIL_PATH"))
        self.firstSpell = Spell()
        self.secondSpell = Spell()
    }
    
    init(playerName: String, champ:Champion, firstSpell: Spell, secondSpell: Spell) {
        self.playerName = playerName
        self.champ = champ
        self.firstSpell = firstSpell
        self.secondSpell = secondSpell
    }
}

struct PlayerFromRiot:Codable{
    let teamId:Int
    let spell1Id:Int
    let spell2Id:Int
    let championId:Int
    let summonerName:String
    
    enum CodingKeys: String, CodingKey {
        case teamId
        case spell1Id
        case spell2Id
        case championId
        case summonerName
    }
}

