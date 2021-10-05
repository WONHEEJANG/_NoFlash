import UIKit

class PlayerViewModel {
    var ALLplayers:[Player] = []
    var enemies:[Player] = []
    var champions:[Champion] = []	
    var spells:[Spell] = []
    
    func loadPlayers(){
        var name = "카트라이더11"
        var key = "RGAPI-38ba4124-318e-473e-a103-14e105bf0704"
        var loginPlayer:Player = Player()
        
        print("파인드 서머너 아이디")
        let summonerID = FindSummonerID(SummonerName: name, key: key)
        let inGameInfo = FindInGameInfo(SummonerID: summonerID, key: key)
        
        print(summonerID)
        print(inGameInfo)
        
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
            
            if name == player.playerName{
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
            let championKey = championFromRiot?.ChampKey ?? ""
           
            let urls = Bundle.main.urls(forResourcesWithExtension: ".png", subdirectory: "Champions") ?? []
            
            var ChampImageURL :URL{
                for url in urls
                {
                    if championName == url.lastPathComponent.replacingOccurrences(of: "_Square_0.png", with: ""){ return url }
                }
                return URL(fileURLWithPath: "")
            }
            
            let champ = Champion(championName: championName, championKey: championKey, championURL: ChampImageURL)
            champions.append(champ)
        }
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
            let spell = Spell(spellName: spellName, coolTime: spellCoolTime, remainTime: spellCoolTime, isUsed: false, spellImageURL: spellImageURl, spellKey: spellkey)
            spells.append(spell)
        }
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
