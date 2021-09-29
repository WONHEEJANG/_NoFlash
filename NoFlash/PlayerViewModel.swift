import UIKit

class PlayerViewModel {
    var players:[Player] = []
    var champions:[Champion] = []	
    var spells:[Spell] = []
     
//    let spellCoolTime:[String:Int] = ["Barrier":180,"Flash":300,"Clarity":240,"Cleanse":210,"Exhaust":210,"Ghost":210,"Heal":240,"Hexflash":20,"Ignite":180,"Smite":90,"Teleport":420]
    
    let spellCoolTime:[String:Int] = ["Barrier":5,"Flash":5,"Clarity":5,"Cleanse":5,"Exhaust":5,"Ghost":5,"Heal":5,"Hexflash":5,"Ignite":5,"Smite":5,"Teleport":5]
    
    // [v] 1. 로그인 한 사람 닉네임으로 summonerInfo 가져오기
    // name -> summonerInfo

    //let url = URL(string: "https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/"+name+"?api_key=" + key)
    // [v] 2. summonerInfo에서 encryptedID 가져오기
    // summonerInfo -> encrpytedID
    
    // [v] 3. encryptedID로 인게임정보 가져오기
    // accountID -> inGameInfo
    //let url = URL(string: "https://kr.api.riotgames.com/lol/spectator/v4/active-games/by-summoner/"+accountID+"?api_key=" + key)
    
    // [] 4. 인게임정보에서 participants 중 팀 200 인 사람들 가져오기
    // [] 5. 팀 200 인 participants 중 championId,summonerName,spell1Id,spell2Id
    // [] 6. championid 로 챔피언 이미지 찾기
    // [] 7. spellid 로 스펠 이미지 찾기
    
    func loadPlayers(){
        var name = "색석필"
        var key = "RGAPI-dc808d24-d7bf-4464-abdc-77a273e2d219"
        
        print("파인드 서머너 아이디")
        let summonerID = FindSummonerID(SummonerName: name, key: key)
        let inGameInfo = FindInGameInfo(SummonerID: summonerID, key: key)
        
        print(summonerID)
        print(inGameInfo)
        
        for player in inGameInfo.participants
        {
            let playerName = player.summonerName
            let champkey = player.championId
            let firstSpellKey = player.spell1Id
            let secondSpellKey = player.spell2Id
            
            
            //champions spells 에서 찾기
            
            let champ = FindChampion(championKey: String(champkey))
            let firstSpell = FindSpell(SpellKey: String(firstSpellKey))
            let secondSpell = FindSpell(SpellKey: String(secondSpellKey))

            let player = Player(playerName: playerName, champ: champ, firstSpell: firstSpell, secondSpell: secondSpell)
            players.append(player)

            print("플레이어플레이어플레이어플레이어플레이어플레이어플레이어플레이어플레이어플레이어플레이어")
            print(player.playerName)
            print(player.champ)
            print(player.firstSpell)
            print(player.secondSpell)

        }
        
    }
    func FindSpell(SpellKey:String)->Spell{
        for spell in spells{
            if spell.spellKey == SpellKey
            {
                return spell
            }
        }
        return Spell.init()
    }
    
    func FindChampion(championKey:String)->Champion{
        print("\n찾을 챔피언키 : \(championKey)")
        for champ in champions{
            if champ.championKey == championKey
            {
                return champ
            }
        }
        return Champion.init()
    }
    
    func FindSummonerID(SummonerName:String, key:String) -> String{
        
        let SummonerInfoURLString =  "https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/"+SummonerName+"?api_key=" + key
        
        let EncodedSummonerInfoURLString = SummonerInfoURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let SummonerInfoURL = URL(string: EncodedSummonerInfoURLString) ?? URL(fileURLWithPath: "")

        var SummonerInfoJSON:Data = try! Data.init(contentsOf: SummonerInfoURL)

        let summonerinfo = try! JSONDecoder().decode(SummonerInfo.self, from: SummonerInfoJSON)
        
        
        return summonerinfo.id
    }
    
    func FindInGameInfo(SummonerID:String, key:String) -> InGameInfo{

        let InGameInfoURLString =  "https://kr.api.riotgames.com/lol/spectator/v4/active-games/by-summoner/"+SummonerID+"?api_key=" + key

        let EncodedInGameInfoURLString = InGameInfoURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        let InGameInfoURL = URL(string: EncodedInGameInfoURLString) ?? URL(fileURLWithPath: "")

        var InGameInfoJSON:Data = try! Data.init(contentsOf: InGameInfoURL)

        let inGameinfo = try! JSONDecoder().decode(InGameInfo.self, from: InGameInfoJSON)


        return inGameinfo
    }
    
    
    func loadRandomPlayers(){
        for index in 1...5
        {
            let playerID = "PLAYER_\(index)"

            //            var champ = Champion() // 짱구 기본이미지
            //            for _champ in champions{
            //                if _champ.championName == "Default"
            //                {champ = _champ}
            //            }

            let champ = champions.randomElement() ?? Champion() // 랜덤 챔피언 이미지
            let firstSpell = spells.randomElement() ?? Spell()
            let secondSpell = spells.randomElement() ?? Spell()
            let player = Player(playerName: playerID, champ: champ, firstSpell: firstSpell, secondSpell: secondSpell)
            players.append(player)
            
            print(player.playerName)
            print(player.champ)
            print(player.firstSpell)
            print(player.secondSpell)

        }
    }
    
    
    
    
//    func loadChampions(){
//        let urls = Bundle.main.urls(forResourcesWithExtension: ".png", subdirectory: "Champions") ?? []
//
//        print("===CHAMPIONS===")
//        for url in urls
//        {
//            let championURL = url
//            let championName = championURL.lastPathComponent.replacingOccurrences(of: "_Square_0.png", with: "")
////            champions.updateValue(championURL, forKey: championName)
//            let champion = Champion(championName: championName, championKey: "", championURL: championURL)
//            champions.append(champion)
//            print(champion.championName)
//        }
//        print(champions.count)
//    }
//
    func loadChampions(){
        
        let fileName = "champion_info"
        let fileType = "json"

        let path = Bundle.main.path(forResource: fileName, ofType: fileType) ?? ""
        let url = URL(fileURLWithPath: path)
        print(path)
        print(url)
        var json:Data = try! Data.init(contentsOf: url)
        
        print("json--\(json)")
        let response = try! JSONDecoder().decode(ChampionResponse.self, from: json)

        print(response)
        
        for champ in response.data{
            let championFromRiot = response.data[champ.key]
            
            let championName = championFromRiot?.ChampionName ?? ""
            let championKey = championFromRiot?.ChampKey ?? ""
           
            let urls = Bundle.main.urls(forResourcesWithExtension: ".png", subdirectory: "Champions") ?? []
            
            var ChampImageURL :URL{
                for url in urls
                {
                    if championName == url.lastPathComponent.replacingOccurrences(of: "_Square_0.png", with: ""){ return url }
                }
                return URL(fileURLWithPath: "")
            }
            
            print("챔피언챔피언챔피언챔피언챔피언챔피언챔피언")
            print(championName)
            print(championKey)
            print(ChampImageURL)
            
            let champ = Champion(championName: championName, championKey: championKey, championURL: ChampImageURL)
            champions.append(champ)
        }
    }

    
    
    func loadSpells(){
// [v] 0. spell codable struct로 바꾸기
// 1. spell_info.json => spell struct로 디코딩
// 2. spells 에 append
        
        let fileName = "spell_info"
        let fileType = "json"

        let path = Bundle.main.path(forResource: fileName, ofType: fileType) ?? ""
        let url = URL(fileURLWithPath: path)
        print(path)
        print(url)
        var json:Data = try! Data.init(contentsOf: url)
        
        print("json--\(json)")
        let response = try! JSONDecoder().decode(SpellResponse.self, from: json)

        print(response)
        
        for spell in response.data{
            let spellFromRiot = response.data[spell.key]
            
            let spellName = spellFromRiot?.spellName ?? ""
            let spellCoolTime = spellFromRiot?.coolTime[0] ?? 0
            let spellkey = spellFromRiot?.spellkey ?? ""
            let urls = Bundle.main.urls(forResourcesWithExtension: ".png", subdirectory: "Spells") ?? []
            
            var spellImageURl :URL{
                for url in urls
                {
                if spellName == url.lastPathComponent.replacingOccurrences(of: ".png", with: ""){ return url }
                }
                return URL(fileURLWithPath: "")
            }
            
            print("스펠스펠스펠")
            print(spellName)
            print(spellImageURl)
            
            let spell = Spell(spellName: spellName, coolTime: spellCoolTime, remainTime: spellCoolTime, isUsed: false, spellImageURL: spellImageURl, spellKey: spellkey)
            spells.append(spell)
        }
    }
}

//{
//    "id": "cqjaJqah7NqErL47qDeOuYqmNq-ZbGABjFMDjq3-codZhXw",
//    "accountId": "OvgA4CbL75MApMzEqqdekoZ6jT0UYeyuIsU-9JlZXOs_RHI",
//    "puuid": "CBjxGkFpz1h5CBinm78qE55nXc8vQtr8Rova501mlrUz4CSWxy_fxe83lAqmS6I4pBJu93PyZuxMBQ",
//    "name": "김도칠",
//    "profileIconId": 4200,
//    "revisionDate": 1632859415000,
//    "summonerLevel": 442
//}

struct SummonerInfo:Codable{
    let id:String
    let accountId:String
    let puuid:String
    let name:String
    let profileIconId:Int
    let revisionDate:Int
    let summonerLevel:Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case accountId
        case puuid
        case name
        case profileIconId
        case revisionDate
        case summonerLevel
    }
}
//"gameId": 5482269862,
//  "mapId": 11,
//  "gameMode": "URF",
//  "gameType": "MATCHED_GAME",
//  "gameQueueConfigId": 900,
//  "participants": [{
//"teamId": 100,
//"spell1Id": 3,
//"spell2Id": 4,
//"championId": 238,
//"profileIconId": 4982,
//"summonerName": "Liggluu",
//"bot": false,
//"summonerId": "G3Xrp_aeqJgqT-wSDys6y3KtfR3Vw1F1xkNfl7u0rxjB_uM",
//"gameCustomizationObjects": []
//},



struct InGameInfo:Codable{
    let gameId:Int
    let mapId:Int
    let gameMode:String
    let gameType:String
    let gameQueueConfigId:Int
    let participants:[PlayerFromRiot]
    
    enum CodingKeys: String, CodingKey {
        case gameId
        case mapId
        case gameMode
        case gameType
        case gameQueueConfigId
        case participants
    }
}
