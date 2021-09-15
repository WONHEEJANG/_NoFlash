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


