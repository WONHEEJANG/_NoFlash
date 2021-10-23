import UIKit

struct Champion{
    let championName:String
    let championName_KR:String
    let championKey:String
    let championURL:URL
    
    var image: UIImage? {
        return UIImage(contentsOfFile: championURL.path)
    }
    init(){
        self.championName = "NIL"
        self.championName_KR = "NIL"
        self.championKey = "NIL"
        self.championURL = URL(fileURLWithPath: "NIL_PATH")

    }
    init(championName: String,championName_KR: String ,championKey:String ,championURL:URL) {
        self.championName = championName
        self.championName_KR = championName_KR
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
    let ChampionName_KR:String
    let ChampKey:String
    
    enum CodingKeys: String, CodingKey {
        case ChampionName = "id"
        case ChampionName_KR = "name"
        case ChampKey = "key"
    }
}


