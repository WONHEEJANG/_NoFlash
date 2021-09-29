import UIKit

struct Champion{
    let championName:String
    let championKey:String
    let championURL:URL
    
    var image: UIImage? {
        return UIImage(contentsOfFile: championURL.path)
    }
    init(){
        self.championName = "NIL"
        self.championKey = "NIL"
        self.championURL = URL(fileURLWithPath: "NIL_PATH")

    }
    init(championName: String, championKey:String ,championURL:URL) {
        self.championName = championName
        self.championKey = championKey
        self.championURL = championURL
    }
}


struct ChampionResponse:Codable{
    
    let type:String
    let data:[String:ChampionFromRiot]
    
    enum CodingKeys: String, CodingKey {
        case type
        case data
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


