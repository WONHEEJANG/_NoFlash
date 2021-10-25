
//https://42kchoi.tistory.com/272
//https://wi0214.tistory.com/5
//https://developer-fury.tistory.com/22


import UIKit

class LoadGameViewController: UIViewController{
    
    var playerName:String = ""
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var LoadGameBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapLoadGameBtnGesture = UITapGestureRecognizer(target: self, action: #selector (tapLoadGameBtn))
        tapLoadGameBtnGesture.numberOfTapsRequired = 1
        LoadGameBtn.addGestureRecognizer(tapLoadGameBtnGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.textField.becomeFirstResponder()
    }
    
    
    @objc func tapLoadGameBtn() {
        print("tapLoadGameBtn")
        print(textField.text)
        
//        let playerStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
//        guard let playerVC = playerStoryboard.instantiateViewController(identifier: "PlayerViewController") as? PlayerViewController else { return }
//        playerVC.playerViewModel.loadPlayers(Name: textField.text ?? "")
//
//        playerVC.isLoaded = true
//        playerVC.reloadView()
        if let presenter = presentingViewController as? PlayerViewController {
            presenter.playerViewModel.loadPlayers(Name: textField.text ?? "")
            presenter.isLoaded = true
            presenter.reloadView()
            print("dismisssssss")
        }
        
        dismiss(animated: true, completion: nil)
    }
}


