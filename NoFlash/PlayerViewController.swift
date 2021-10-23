import UIKit
import MarqueeLabel

class PlayerViewController: UIViewController{
    
    let playerViewModel = PlayerViewModel()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // DetailViewController 데이터 줄꺼에요
        if segue.identifier == "showChampions" {
            let vc = segue.destination as? SelectChampionViewController
            vc?.champions = sender as! [Champion]
        }
        
        if segue.identifier == "showSpells" {
            let vc = segue.destination as? SelectSpellViewController
            vc?.spells = sender as! [Spell]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerViewModel.loadChampions()
        playerViewModel.loadSpells()
        playerViewModel.loadDefaultPlayers()
        
//        playerViewModel.loadRandomPlayers()
//        playerViewModel.loadPlayers()
        
    }
    
//    @IBAction func loadGame(_ sender: Any) {
//        playerViewModel.loadPlayers()
//    }

    @objc func tapSpell() {
        print("tapSpell")
    }
    
    @objc func longtapSpell() {

        print("longtapSpell")
        performSegue(withIdentifier: "showSpells", sender: playerViewModel.spells)
    }
    
    @objc func tapChampion() {

        print("tapChampion")
        performSegue(withIdentifier: "showChampions", sender: playerViewModel.champions)
      
    }

    @objc func longtapChampion() {

        print("longtapChampion")
    }
    
    @objc func tap2400() {

        print("tap2400")
        performSegue(withIdentifier: "loadGame", sender: nil)
      
    }

    @objc func longtap2400() {

        print("longtap2400")
    }
}

extension PlayerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerViewCell", for: indexPath) as? PlayerViewCell else
        { return UICollectionViewCell() }

        let player = playerViewModel.enemies[indexPath.row]
        cell.update(player: player)

        
        let ChampionTapGesture = UITapGestureRecognizer(target: self, action: #selector (tapChampion))
        let ChampionLongGesture = UILongPressGestureRecognizer(target: self, action: #selector(longtapChampion))
        ChampionTapGesture.numberOfTapsRequired = 1
        cell.champBtn.addGestureRecognizer(ChampionTapGesture)
        cell.champBtn.addGestureRecognizer(ChampionLongGesture)
        
        let FirstSpellLongGesture = UILongPressGestureRecognizer(target: self, action: #selector(longtapSpell))
        let SecondSpellLongGesture = UILongPressGestureRecognizer(target: self, action: #selector(longtapSpell))
        cell.firstSpellBtn.addGestureRecognizer(FirstSpellLongGesture)
        cell.secondSpellBtn.addGestureRecognizer(SecondSpellLongGesture)
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PlayerHeaderView", for: indexPath) as? PlayerHeaderView else {
                return UICollectionReusableView()
            }
            
            let LoadGameTapGesture = UITapGestureRecognizer(target: self, action: #selector (tap2400))  //Tap function will call when user tap on button
            let LoadGameLongGesture = UILongPressGestureRecognizer(target: self, action: #selector(longtap2400))  //Long function will call when user long press on button.
            LoadGameTapGesture.numberOfTapsRequired = 1
            header.loadGameBtn.addGestureRecognizer(LoadGameTapGesture)
            header.loadGameBtn.addGestureRecognizer(LoadGameLongGesture)
            

            return header
        default:
            return UICollectionReusableView()
        }
    }
}


extension PlayerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 20 - card(width) - 20 - card(width) - 20
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = (collectionView.bounds.height - 90) / 6

        return CGSize(width: width, height: height)
    }
}
