
//https://42kchoi.tistory.com/272
//https://wi0214.tistory.com/5
//https://developer-fury.tistory.com/22


import UIKit

class LoadGameViewController: UIViewController, UITextFieldDelegate{
    
    var playerName:String = ""
    let alert_NOTFOUND = UIAlertController(title: "알림", message: "소환사를 찾을 수 없어요\n이름을 다시 입력해주세요", preferredStyle: .alert)
    let alert_NOTPLAYING = UIAlertController(title: "알림", message: "게임 중인 소환사가 아니에요", preferredStyle: .alert)
    var LoadGameBtnToBottom_origin = CGFloat()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var LoadGameBtn: UIButton!
    @IBOutlet weak var LoadGameBtnToBottomSafeArea: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadGameBtnToBottom_origin = LoadGameBtnToBottomSafeArea.constant
        
        setKeyboardObserver()
        
        textField.delegate = self
        
        let tapLoadGameBtnGesture = UITapGestureRecognizer(target: self, action: #selector (tapLoadGameBtn))
        tapLoadGameBtnGesture.numberOfTapsRequired = 1
        LoadGameBtn.addGestureRecognizer(tapLoadGameBtnGesture)
        
        alert_NOTFOUND.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
            }
        }))
        alert_NOTPLAYING.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
            }
        }))
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.textField.resignFirstResponder()
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

            self.textField.resignFirstResponder()
        
            if let presenter = presentingViewController as? PlayerViewController {
            
            switch presenter.playerViewModel.loadPlayers(Name: textField.text ?? "") {
            case "FOUND":
                presenter.isLoaded = true
                presenter.reloadView()
                print("dismisssssss")
                dismiss(animated: true, completion: nil)
            case "NOT FOUND":
                self.present(self.alert_NOTFOUND, animated: true, completion: nil)
            case "NOT PLAYING":
                self.present(self.alert_NOTPLAYING, animated: true, completion: nil)
            default:
                print("default")
            }
        }
        
            return true
        }

    
    override func viewWillAppear(_ animated: Bool) {
        self.textField.becomeFirstResponder()
    }
    
    
    @objc func tapLoadGameBtn() {
        print("tapLoadGameBtn")
        print(textField.text)
        
        if let presenter = presentingViewController as? PlayerViewController {
            
            switch presenter.playerViewModel.loadPlayers(Name: textField.text ?? "") {
            case "FOUND":
                presenter.isLoaded = true
                presenter.reloadView()
                print("dismisssssss")
                dismiss(animated: true, completion: nil)
            case "NOT FOUND":
                self.present(self.alert_NOTFOUND, animated: true, completion: nil)
            case "NOT PLAYING":
                self.present(self.alert_NOTPLAYING, animated: true, completion: nil)
            default:
                print("default")
            }
        }
    }
}

extension LoadGameViewController {
    
    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(LoadGameViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoadGameViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
           if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                   let keyboardRectangle = keyboardFrame.cgRectValue
                   let keyboardHeight = keyboardRectangle.height
               UIView.animate(withDuration: 1) {
                   self.LoadGameBtnToBottomSafeArea.constant = keyboardHeight
                   self.view.layoutIfNeeded()
               }
           }
        print("keyboardwillshow")
        print(LoadGameBtnToBottom_origin)
        print(self.LoadGameBtnToBottomSafeArea.constant)
       }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if LoadGameBtnToBottom_origin != LoadGameBtnToBottomSafeArea.constant {
                if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                        let keyboardRectangle = keyboardFrame.cgRectValue
                        let keyboardHeight = keyboardRectangle.height
                    
                    UIView.animate(withDuration: 1) {
                        self.LoadGameBtnToBottomSafeArea.constant = 0
                        self.view.layoutIfNeeded()
                    }
                }
            }
        print("keyboardwillhide")
        print(LoadGameBtnToBottom_origin)
        print(self.LoadGameBtnToBottomSafeArea.constant)
        }
}
