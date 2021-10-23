import UIKit

class SelectSpellViewController: UIViewController{
    
    var spells:[Spell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("numOfSpellsnumOfSpellsnumOfSpellsnumOfSpells")
        print(spells.count)
    }
}

extension SelectSpellViewController: UICollectionViewDataSource {
    // 몇개 표시 할까?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spells.count
    }
    
    // 셀 어떻게 표시 할까?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectSpellViewCell", for: indexPath) as? SelectSpellViewCell else {
            return UICollectionViewCell()
        }
        print(indexPath.row)
        cell.SpelllImgView.image = spells[indexPath.row].image
        cell.SpellNameLabel.text = spells[indexPath.row].spellName_KR

        return cell
    }
}

extension SelectSpellViewController: UICollectionViewDelegate {
    // 클릭했을때 어떻게 할까?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

extension SelectSpellViewController: UICollectionViewDelegateFlowLayout {
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
