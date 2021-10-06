import UIKit
import AudioToolbox

class PlayerViewCell: UICollectionViewCell{
    @IBOutlet weak var lineNameLabel: UILabel!
    @IBOutlet weak var champImgView: UIImageView!
    @IBOutlet weak var champBtn: UIButton!
    
    
    @IBOutlet weak var firstSpellImgView: UIImageView!
    @IBOutlet weak var firstSpellBtn: UIButton!
    @IBOutlet weak var FirstSpellCoolTimeLabel: UILabel!
    
    @IBOutlet weak var secondSpellImgView: UIImageView!
    @IBOutlet weak var secondSpellBtn: UIButton!
    @IBOutlet weak var SecondSpellCoolTimeLabel: UILabel!
    
    var firstSpellTimer:Timer?
    var secondSpellTimer:Timer?
    
    var firstSpellRemainTime:Int = 0
    var firstSpellCoolTime:Int = 0
    var secondSpellRemainTime:Int = 0
    var secondSpellCoolTime:Int = 0
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        print("CELL_AWAKEFROMNIB")
//        longPressHandler()
//    }
//
//    func longPressHandler(){
//        var lpgr = UILongPressGestureRecognizer()
//        champBtn.addGestureRecognizer(lpgr)
//        lpgr.addTarget(self, action: #selector(champlongpress))
//    }
//    @objc func champlongpress()
//    {
//        print("champ long press")
//    }
//
    
    func flipWhenFirstSpellComplete(){
        print("flipWhenFirstSpellComplete")
        AudioServicesPlaySystemSound(4095)
        isTappedFirstSpell((Any).self)
    }
    
    func flipWhenSecondSpellComplete(){
        print("flipWhenSecondSpellComplete")
        AudioServicesPlaySystemSound(4095)
        isTappedSecondSpell((Any).self)
    }
    
    @objc func firstSpellTimeCheck()
    {
        print("firstSpellRemainTime")
        print(firstSpellRemainTime)
        print("firstSpellCoolTime")
        print(firstSpellCoolTime)
        
        firstSpellRemainTime = Int(FirstSpellCoolTimeLabel.text ?? "0") ?? 0
        firstSpellRemainTime -= 1
        FirstSpellCoolTimeLabel.text = "\(firstSpellRemainTime)"
        if firstSpellRemainTime <= 0
        {
            firstSpellTimer?.invalidate()
            firstSpellTimer = nil
            flipWhenFirstSpellComplete()
        }
    }
    
    @objc func secondSpellTimeCheck()
    {
        print("secondSpellRemainTime")
        print(secondSpellRemainTime)
        
        secondSpellRemainTime = Int(SecondSpellCoolTimeLabel.text ?? "0") ?? 0
        secondSpellRemainTime -= 1
        SecondSpellCoolTimeLabel.text = "\(secondSpellRemainTime)"
        
        if secondSpellRemainTime <= 0
        {
            secondSpellTimer?.invalidate()
            secondSpellTimer = nil
            flipWhenSecondSpellComplete()
        }
    }
//
//    @IBAction func champBtnTapped(_ sender: Any) {
//    }
//
//    @IBAction func longPressed(sender: UILongPressGestureRecognizer)
//    {
//        print("longpressed")
//        //Different code
//    }
    
    
    
    
    func update(player: Player) {
        let name = player.playerName
        let champion = player.champ
        let firstSpell = player.firstSpell
        let secondSpell = player.secondSpell
        
        lineNameLabel.text = name

        champImgView.image = champion.image
        
        firstSpellImgView.image = firstSpell.image
        FirstSpellCoolTimeLabel.text = "\(firstSpell.coolTime)"
        
        secondSpellImgView.image = secondSpell.image
        SecondSpellCoolTimeLabel.text = "\(secondSpell.coolTime)"
        
    }
    
    
    
    
    @IBAction func isTappedFirstSpell(_ sender: Any) {

        UIView.transition(with: firstSpellImgView,
                          duration: 0.4,
                          options: .transitionFlipFromLeft,
                          animations: nil, completion: nil)

        if firstSpellBtn.isSelected{
            firstSpellBtn.isSelected = false
            firstSpellImgView.alpha = 1
            FirstSpellCoolTimeLabel.alpha = 0
            
            
            firstSpellRemainTime = firstSpellCoolTime
            FirstSpellCoolTimeLabel.text = "\(firstSpellRemainTime)"
            
            firstSpellTimer?.invalidate()
            firstSpellTimer = nil

        }
        else{
            firstSpellCoolTime = Int(FirstSpellCoolTimeLabel.text ?? "0") ?? 0
            
            firstSpellTimer = Timer.init(timeInterval: 1.0, target: self, selector: #selector(firstSpellTimeCheck), userInfo: nil, repeats: true)
            RunLoop.current.add(firstSpellTimer!, forMode: .common)
            
            print("firstSpellTimer")
            print(firstSpellTimer)
            
            
            firstSpellBtn.isSelected = true
            firstSpellImgView.alpha = 0.2
            
            
            
            UIView.animateKeyframes(withDuration: 0.1, delay: 0.2, options: .allowUserInteraction, animations: {self.FirstSpellCoolTimeLabel.alpha = 1}, completion: nil)

        }
    }
    
    @IBAction func isTappedSecondSpell(_ sender: Any) {
        UIView.transition(with: secondSpellImgView,
                          duration: 0.4,
                          options: .transitionFlipFromLeft,
                          animations: nil, completion: nil)
        
        if secondSpellBtn.isSelected{
            secondSpellBtn.isSelected = false
            secondSpellImgView.alpha = 1
            SecondSpellCoolTimeLabel.alpha = 0
            
            secondSpellRemainTime = secondSpellCoolTime
            SecondSpellCoolTimeLabel.text = "\(secondSpellRemainTime)"

            secondSpellTimer?.invalidate()
            secondSpellTimer = nil
        }
        else{
            secondSpellCoolTime = Int(SecondSpellCoolTimeLabel.text ?? "0") ?? 0
            secondSpellTimer = Timer.init(timeInterval: 1.0, target: self, selector: #selector(secondSpellTimeCheck), userInfo: nil, repeats: true)
            RunLoop.current.add(secondSpellTimer!, forMode: .common)
            
            secondSpellBtn.isSelected = true
            secondSpellImgView.alpha = 0.2
            UIView.animateKeyframes(withDuration: 0.1, delay: 0.2, options: .allowUserInteraction, animations: {self.SecondSpellCoolTimeLabel.alpha = 1}, completion: nil)
        }
    }
}
