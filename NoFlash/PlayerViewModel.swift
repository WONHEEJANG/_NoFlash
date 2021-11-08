import UIKit

class PlayerViewModel {
    var ALLplayers:[Player] = []
    var enemies:[Player] = []
    var champions:[Champion] = []	
    var spells:[Spell] = []
    
    func loadPlayers(Name:String) -> String {
        let key = "RGAPI-9d1f234c-c20f-4fad-963e-5e391d815db7"
        var loginPlayer:Player = Player()
        
        print("파인드 서머너 아이디")
        let summonerID = FindSummonerID(SummonerName: Name, key: key)
        
        print(summonerID)
        print(summonerID)
        print(summonerID)
        
        if summonerID == "default"
        {
            return "NOT FOUND"
        }
        
        let inGameInfo = FindInGameInfo(SummonerID: summonerID, key: key)
        
        if inGameInfo.gameId == 0
        {
            return "NOT PLAYING"
        }
        
        
        print(summonerID)
        print(inGameInfo)
        
        ALLplayers = []
        enemies = []
        
        for player in inGameInfo.participants
        {
            let teamId = player.teamId
            let playerName = player.summonerName
            let champkey = player.championId
            let firstSpellKey = player.spell1Id
            let secondSpellKey = player.spell2Id
            
            
            //champions spells 에서 찾기
            let champ = FindChampion(championKey: String(champkey))
            let firstSpell = FindSpell(SpellKey: String(firstSpellKey))
            let secondSpell = FindSpell(SpellKey: String(secondSpellKey))

            let player = Player(teamId:teamId, playerName: playerName, champ: champ, firstSpell: firstSpell, secondSpell: secondSpell)
            
            if Name == player.playerName{
                loginPlayer = player
            }
            
            ALLplayers.append(player)

            print("======================PLAYTER======================")
            print("TEAMID : \(player.teamId)")
            print("NAME : \(player.playerName)")
            print(player.champ)
            print(player.firstSpell)
            print(player.secondSpell)

        }
        
        for player in ALLplayers{
            if player.teamId != loginPlayer.teamId{
                enemies.append(player)
            }
        }
        
        return "FOUND"
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
        var summonerinfo = SummonerInfo(id: "default", accountId: "default", puuid: "default", name: "default", profileIconId: 0, revisionDate: 0, summonerLevel: 0)
        
        if let SummonerInfoJSON:Data = try? Data.init(contentsOf: SummonerInfoURL){
            summonerinfo = try! JSONDecoder().decode(SummonerInfo.self, from: SummonerInfoJSON)
            
            print("summonerinfo")
            
            print(summonerinfo)
            print(summonerinfo)
            print(summonerinfo)
        }
        
        return summonerinfo.id
    }
    
    func FindInGameInfo(SummonerID:String, key:String) -> InGameInfo{

        let InGameInfoURLString =  "https://kr.api.riotgames.com/lol/spectator/v4/active-games/by-summoner/"+SummonerID+"?api_key=" + key

        let EncodedInGameInfoURLString = InGameInfoURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        let InGameInfoURL = URL(string: EncodedInGameInfoURLString) ?? URL(fileURLWithPath: "")
        var inGameinfo = InGameInfo(gameId: 0, mapId: 0, gameMode: "", gameType: "", gameQueueConfigId: 0, participants: [])
        
        if let InGameInfoJSON:Data = try? Data.init(contentsOf: InGameInfoURL){
            inGameinfo = try! JSONDecoder().decode(InGameInfo.self, from: InGameInfoJSON)
        }
        else{
            print("elseelseelseelseelseelseelse")

        }
//        var InGameInfoJSON:Data = try! Data.init(contentsOf: InGameInfoURL)
//
//        let inGameinfo = try! JSONDecoder().decode(InGameInfo.self, from: InGameInfoJSON)


        return inGameinfo
    }
    
    
    func loadRandomPlayers(){
        for index in 1...5
        {
            let playerID = "PLAYER_\(index)"

                        var champ = Champion() // 랄로 기본이미지
                        for _champ in champions{
                            if _champ.championName == "Ralo"
                            {champ = _champ}
                        }

//            let champ = champions.randomElement() ?? Champion() // 랜덤 챔피언 이미지
            let firstSpell = spells.randomElement() ?? Spell()
            let secondSpell = spells.randomElement() ?? Spell()
            let player = Player(teamId: 150, playerName: playerID, champ: champ, firstSpell: firstSpell, secondSpell: secondSpell)
            enemies.append(player)
            
            print(player.playerName)
            print(player.champ)
            print(player.firstSpell)
            print(player.secondSpell)

        }
    }
    
    func loadDefaultPlayers(){
        
        print("loadDefaultPlayers")
        for index in 1...5
        {
            let playerID = "PLAYER_\(index)"

            var champ = Champion() // 랄로 기본이미지
            for _champ in champions{
                if _champ.championName == "Ralo"
                {champ = _champ}
            }

//            let champ = champions.randomElement() ?? Champion() // 랜덤 챔피언 이미지
//            let firstSpell = spells.randomElement() ?? Spell()
//            let secondSpell = spells.randomElement() ?? Spell()
            var firstSpell = Spell()
            var secondSpell = Spell()
            
            for _spell in spells{
                if _spell.spellName == "SummonerDefault"
                {
                    firstSpell = _spell
                    secondSpell = _spell
                }
            }
            
            let player = Player(teamId: 150, playerName: playerID, champ: champ, firstSpell: firstSpell, secondSpell: secondSpell)
            enemies.append(player)
            
            print(player.playerName)
            print(player.champ)
            print(player.firstSpell)
            print(player.secondSpell)

        }
    }
    
    func loadChampions(){
        
        let fileName = "champion_info"
        let fileType = "json"

        let path = Bundle.main.path(forResource: fileName, ofType: fileType) ?? ""
        let url = URL(fileURLWithPath: path)

        var json:Data = try! Data.init(contentsOf: url)
        let response = try! JSONDecoder().decode(ChampionResponse.self, from: json)
        
        for champ in response.data{
            let championFromRiot = response.data[champ.key]
            
            let championName = championFromRiot?.ChampionName ?? ""
            let championName_KR = championFromRiot?.ChampionName_KR ?? ""
            let championKey = championFromRiot?.ChampKey ?? ""
           
            let urls = Bundle.main.urls(forResourcesWithExtension: ".png", subdirectory: "Champions") ?? []
            
            var ChampImageURL :URL{
                for url in urls
                {
                    if championName == url.lastPathComponent.replacingOccurrences(of: "_Square_0.png", with: ""){ return url }
                }
                return URL(fileURLWithPath: "")
            }
            
            let champ = Champion(championName: championName, championName_KR: championName_KR, championKey: championKey, championURL: ChampImageURL)
            champions.append(champ)
        }
        // 랄로 찾기
        let urls = Bundle.main.urls(forResourcesWithExtension: ".png", subdirectory: "Champions") ?? []
        
        var RaloImageURL :URL{
            for url in urls
            {
                if "Ralo" == url.lastPathComponent.replacingOccurrences(of: "_Square_0.png", with: ""){ return url }
            }
            return URL(fileURLWithPath: "")
        }
        // 랄로 추가
        champions.append(Champion(championName: "Ralo", championName_KR: "랄선생", championKey: "2400", championURL: RaloImageURL))
    }

    
    
    func loadSpells(){
        let fileName = "spell_info"
        let fileType = "json"

        let path = Bundle.main.path(forResource: fileName, ofType: fileType) ?? ""
        let url = URL(fileURLWithPath: path)
        
        var json:Data = try! Data.init(contentsOf: url)
        let response = try! JSONDecoder().decode(SpellResponse.self, from: json)

        for spell in response.data{
            let spellFromRiot = response.data[spell.key]
            
            let spellName = spellFromRiot?.spellName ?? ""
            let spellName_KR = spellFromRiot?.spellName_KR ?? ""
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
            let spell = Spell(spellName: spellName, spellName_KR: spellName_KR, coolTime: spellCoolTime, remainTime: spellCoolTime, isUsed: false, spellImageURL: spellImageURl, spellKey: spellkey)
            spells.append(spell)
        }
        // 도지 찾기
        let urls = Bundle.main.urls(forResourcesWithExtension: ".png", subdirectory: "Spells") ?? []
        
        var DogeImageURL :URL{
            for url in urls
            {
                if "SummonerDefault" == url.lastPathComponent.replacingOccurrences(of: ".png", with: ""){ return url }
            }
            return URL(fileURLWithPath: "")
        }
        // 도지 추가
        spells.append(Spell(spellName: "SummonerDefault", spellName_KR: "도지", coolTime: 777, remainTime: 777, isUsed: false, spellImageURL: DogeImageURL, spellKey: "777"))
    }
}

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
