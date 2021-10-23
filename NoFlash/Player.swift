import UIKit

struct Player{
    var teamId:Int
    var playerName:String
    var champ:Champion
    var firstSpell:Spell
    var secondSpell:Spell
    
    init(){
        self.teamId = 0
        self.playerName = "NIL"
        self.champ = Champion(championName: "NIL_CHAMP", championName_KR: "NIL_CHAMP", championKey: "NIL", championURL: URL(fileURLWithPath: "NIL_PATH"))
        self.firstSpell = Spell()
        self.secondSpell = Spell()
    }
    
    init(teamId: Int, playerName: String, champ:Champion, firstSpell: Spell, secondSpell: Spell) {
        self.teamId = teamId
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

