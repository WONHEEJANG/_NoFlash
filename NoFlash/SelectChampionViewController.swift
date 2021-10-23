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
        cell.champNameLabel.text = champions[indexPath.row].championName_KR

        return cell
    }
}

extension SelectChampionViewController: UICollectionViewDelegate {
    // 클릭했을때 어떻게 할까?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

extension SelectChampionViewController: UICollectionViewDelegateFlowLayout {
    // 셀 사이즈 어떻게 할까?
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 20 - card(width) - 20 - card(width) - 20
        let width: CGFloat = (collectionView.bounds.width - (20 * 3))/2
        let height: CGFloat = width + 60
        print(width)
        print(height)
        return CGSize(width: width, height: height)
    }
}
