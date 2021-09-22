import UIKit

struct Champion{
    let championName:String
    let championURL:URL
    
    var image: UIImage? {
        return UIImage(contentsOfFile: championURL.path)
    }
    init(){
        self.championName = "NIL"
        self.championURL = URL(fileURLWithPath: "NIL_PATH")
    }
    init(championName: String, championURL:URL) {
        self.championName = championName
        self.championURL = championURL
    }
}


struct ChampionFromRiot:Codable{
    let ChampionName:String
    let ChampKey:String
    
    enum CodingKeys: String, CodingKey {
        case ChampionName = "id"
        case ChampKey = "key"
    }
}


