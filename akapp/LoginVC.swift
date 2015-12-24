import UIKit
import Parse

class LoginViewController: UIViewController,UITextFieldDelegate {
  @IBOutlet weak var userTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var logInButton: UIButton!
  
  let scrollViewWallSegue = "LoginSuccesful"
  let tableViewWallSegue = "LoginSuccesfulTable"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    userTextField.delegate = self
    passwordTextField.delegate = self
    userTextField.tag = 1
    passwordTextField.tag = 2
    if let user = PFUser.currentUser() {
      if user.authenticated {
        self.performSegueWithIdentifier(tableViewWallSegue, sender: nil)
      }
    }
  }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        userTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        super.touchesBegan(touches, withEvent: event)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.tag == 1{
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        else if textField.tag == 2{
            textField.resignFirstResponder()
            logInPressed(logInButton)
        }

        return true
    }

  
  @IBAction func logInPressed(sender: AnyObject) {
    PFUser.logInWithUsernameInBackground(userTextField.text!, password: passwordTextField.text!) { user, error in
      if user != nil {
        self.performSegueWithIdentifier(self.tableViewWallSegue, sender: nil)
      } else if let error = error {
        self.showErrorView(error)
      }
    }
  }
}
