import UIKit

struct Spell{
    let spellName:String
    let spellName_KR:String
    let coolTime:Int
    let remainTime:Int
    let isUsed:Bool
    let spellImageURL:URL
    let spellKey:String
    
    var image: UIImage? {
        return UIImage(contentsOfFile: spellImageURL.path)
    }
    init(){
        self.spellName = "NIL"
        self.spellName_KR = "NIL"
        self.coolTime = 777
        self.remainTime = 777
        self.isUsed = true
        self.spellImageURL = URL(fileURLWithPath: "NIL_PATH")
        self.spellKey = "NIL"
    }
    
    init(spellName: String, spellName_KR: String, coolTime: Int, remainTime: Int, isUsed: Bool, spellImageURL:URL, spellKey:String) {
        self.spellName = spellName
        self.spellName_KR = spellName_KR
        self.coolTime = coolTime
        self.remainTime = remainTime
        self.isUsed = isUsed
        self.spellImageURL = spellImageURL
        self.spellKey = spellKey
    }
}

struct SpellFromRiot:Codable{
    let spellName:String
    let spellName_KR:String
    let coolTime:[Int]
    let spellkey:String
    
    enum CodingKeys: String, CodingKey {
        case spellName = "id"
        case spellName_KR = "name"
        case coolTime = "cooldown"
        case spellkey = "key"
        
    }
}

struct SpellResponse:Codable{
    
    let type:String
    let data:[String:SpellFromRiot]
    
    enum CodingKeys: String, CodingKey {
        case type
        case data
    }
}
