
//https://42kchoi.tistory.com/272
//https://wi0214.tistory.com/5
//https://developer-fury.tistory.com/22


import UIKit

class LoadGameViewController: UIViewController{
    
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.textField.becomeFirstResponder()
    }
}
