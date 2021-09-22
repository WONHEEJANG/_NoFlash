import UIKit

class PlayerViewModel {
    var players:[Player] = []
    var champions:[Champion] = []
    var spells:[Spell] = []
//    let spellCoolTime:[String:Int] = ["Barrier":180,"Flash":300,"Clarity":240,"Cleanse":210,"Exhaust":210,"Ghost":210,"Heal":240,"Hexflash":20,"Ignite":180,"Smite":90,"Teleport":420]
    
    let spellCoolTime:[String:Int] = ["Barrier":5,"Flash":5,"Clarity":5,"Cleanse":5,"Exhaust":5,"Ghost":5,"Heal":5,"Hexflash":5,"Ignite":5,"Smite":5,"Teleport":5]
    
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
            let player = Player(playerID: playerID, champ: champ, firstSpell: firstSpell, secondSpell: secondSpell)
            players.append(player)
            
            print(player.playerID)
            print(player.champ)
            print(player.firstSpell)
            print(player.secondSpell)

        }
    }
    
    
    func loadChampions(){
        let urls = Bundle.main.urls(forResourcesWithExtension: ".png", subdirectory: "Champions") ?? []
        
        print("===CHAMPIONS===")
        for url in urls
        {
            let championURL = url
            let championName = championURL.lastPathComponent.replacingOccurrences(of: "_Square_0.png", with: "")
//            champions.updateValue(championURL, forKey: championName)
            let champion = Champion(championName: championName, championURL: championURL)
            champions.append(champion)
            print(champion.championName)
        }
        print(champions.count)
    }
    
    func loadSpells(){
// 0. spell codable struct로 바꾸기
// 1. spell_info.json => spell struct로 디코딩
// 2. spells 에 append
        
        
        let urls = Bundle.main.urls(forResourcesWithExtension: ".png", subdirectory: "Spells") ?? []
        
        print("\n\n\n===SPELLS===")
        for url in urls
        {
            let spellURL = url
            let spellName = url.lastPathComponent.replacingOccurrences(of: ".png", with: "")
            let spellCoolTime = spellCoolTime["\(spellName)"] ?? 0
            
            let spell = Spell(spellName: spellName, coolTime: spellCoolTime, remainTime: spellCoolTime, isUsed: false, spellURL: spellURL)
            spells.append(spell)
            print(spell.spellName)
        }
        print(spells.count)
    }
    
}



