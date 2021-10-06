import UIKit

class PlayerViewController: UIViewController{
    
    let playerViewModel = PlayerViewModel()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // DetailViewController 데이터 줄꺼에요
        if segue.identifier == "showChampions" {
            let vc = segue.destination as? SelectChampionViewController
            vc?.champions = sender as! [Champion]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerViewModel.loadChampions()
        playerViewModel.loadSpells()
        playerViewModel.loadRandomPlayers()
//        playerViewModel.loadPlayers()
        
    }
    
    @IBAction func loadGame(_ sender: Any) {
        playerViewModel.loadPlayers()
    }
    
    @objc func tap() {

        print("Tap happend")
        performSegue(withIdentifier: "showChampions", sender: playerViewModel.champions)
      
    }

    @objc func long() {

        print("Long press")
//        performSegue(withIdentifier: "showChampions", sender: playerViewModel.champions)
//        let vcname = self.storyboard?.instantiateViewController(withIdentifier: "SelectChampionViewController") ?? UIViewController()
//        self.present(vcname, animated: true, completion: nil)
    }

}

extension PlayerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
//        return playerViewModel.champions.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerViewCell", for: indexPath) as? PlayerViewCell else
        { return UICollectionViewCell() }

        let player = playerViewModel.enemies[indexPath.row]
        switch indexPath.row {
        case 0:
            cell.lineNameLabel.text = "TOP"
            cell.update(player: player)
        case 1:
            cell.lineNameLabel.text = "JG"
            cell.update(player: player)
        case 2:
            cell.lineNameLabel.text = "MID"
            cell.update(player: player)
        case 3:
            cell.lineNameLabel.text = "AD"
            cell.update(player: player)
        case 4:
            cell.lineNameLabel.text = "SPT"
            cell.update(player: player)
        default:
            cell.lineNameLabel.text = "DEFAULT"
            cell.update(player: player)
        }
        
        let ChampionTapGesture = UITapGestureRecognizer(target: self, action: #selector (tap))  //Tap function will call when user tap on button
        let ChampionLongGesture = UILongPressGestureRecognizer(target: self, action: #selector(long))  //Long function will call when user long press on button.
        ChampionTapGesture.numberOfTapsRequired = 1
        cell.champBtn.addGestureRecognizer(ChampionTapGesture)
        cell.champBtn.addGestureRecognizer(ChampionLongGesture)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PlayerHeaderView", for: indexPath) as? PlayerHeaderView else {
                return UICollectionReusableView()
            }

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
