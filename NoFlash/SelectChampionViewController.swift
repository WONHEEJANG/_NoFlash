import UIKit

class SelectChampionViewController: UIViewController{
    
    var champions:[Champion] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("numOfchampionsnumOfchampionsnumOfchampionsnumOfchampionsnumOfchampions")
        print(champions.count)
    }
}

extension SelectChampionViewController: UICollectionViewDataSource {
    // 몇개 표시 할까?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return champions.count
    }
    
    // 셀 어떻게 표시 할까?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectChampionViewCell", for: indexPath) as? SelectChampionViewCell else {
            return UICollectionViewCell()
        }
        print(indexPath.row)
        cell.champImgView.image = champions[indexPath.row].image
//        let item = trackManager.track(at: indexPath.item)
//        cell.updateUI(item: item)
        return cell
    }
}

extension SelectChampionViewController: UICollectionViewDelegate {
//    // 클릭했을때 어떻게 할까?
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let playerStoryboard = UIStoryboard.init(name: "Player", bundle: nil)
//        guard let playerVC = playerStoryboard.instantiateViewController(identifier: "PlayerViewController") as? PlayerViewController else { return }
//        let item = trackManager.tracks[indexPath.item]
//        playerVC.simplePlayer.replaceCurrentItem(with: item)
//        present(playerVC, animated: true, completion: nil)
//    }
}

extension SelectChampionViewController: UICollectionViewDelegateFlowLayout {
    // 셀 사이즈 어떻게 할까?
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 20 - card(width) - 20 - card(width) - 20
        let width: CGFloat = (collectionView.bounds.width - (20 * 3))/2
        let height: CGFloat = width + 60
        return CGSize(width: width, height: height)
    }
}
