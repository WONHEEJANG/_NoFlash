import UIKit

struct Spell {
    let spellName:String
    let coolTime:Int
    let remainTime:Int
    let isUsed:Bool
    let spellURL:URL
    
    var image: UIImage? {
        return UIImage(contentsOfFile: spellURL.path)
    }
    init(){
        self.spellName = "NIL"
        self.coolTime = 777
        self.remainTime = 777
        self.isUsed = true
        self.spellURL = URL(fileURLWithPath: "NIL_PATH")
    }
    
    init(spellName: String, coolTime: Int, remainTime: Int, isUsed: Bool, spellURL:URL) {
        self.spellName = spellName
        self.coolTime = coolTime
        self.remainTime = remainTime
        self.isUsed = isUsed
        self.spellURL = spellURL
    }
}


//
//struct BountyInfo {
//    let name: String
//    let bounty: Int
//
//    var image: UIImage? {
//        return UIImage(named: "\(name).jpg")
//    }
//
//    init(name: String, bounty: Int) {
//        self.name = name
//        self.bounty = bounty
//    }
//}
