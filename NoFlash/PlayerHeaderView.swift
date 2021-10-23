import UIKit
import MarqueeLabel


class PlayerHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var titleLabel: MarqueeLabel!
    @IBOutlet weak var loadGameBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }    
}





    
    // 헤더뷰 어떻게 표시할까?
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        switch kind {
//        case UICollectionView.elementKindSectionHeader:
//            guard let item = trackManager.todaysTrack else {
//                return UICollectionReusableView()
//            }
//
//            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TrackCollectionHeaderView", for: indexPath) as? TrackCollectionHeaderView else {
//                return UICollectionReusableView()
//            }
//
//            header.update(with: item)
//            header.tapHandler = { item in
//                let playerStoryboard = UIStoryboard.init(name: "Player", bundle: nil)
//                guard let playerVC = playerStoryboard.instantiateViewController(identifier: "PlayerViewController") as? PlayerViewController else { return }
//                playerVC.simplePlayer.replaceCurrentItem(with: item)
//                self.present(playerVC, animated: true, completion: nil)
//            }
//
//            return header
//        default:
//            return UICollectionReusableView()
//        }
//    }
//}
//
//extension HomeViewController: UICollectionViewDelegate {
//    // 클릭했을때 어떻게 할까?
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let playerStoryboard = UIStoryboard.init(name: "Player", bundle: nil)
//        guard let playerVC = playerStoryboard.instantiateViewController(identifier: "PlayerViewController") as? PlayerViewController else { return }
//        let item = trackManager.tracks[indexPath.item]
//        playerVC.simplePlayer.replaceCurrentItem(with: item)
//        present(playerVC, animated: true, completion: nil)
//    }
//}

