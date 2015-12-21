import UIKit
import Parse

class LoginViewController: UIViewController {
  @IBOutlet weak var userTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  let scrollViewWallSegue = "LoginSuccesful"
  let tableViewWallSegue = "LoginSuccesfulTable"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let user = PFUser.currentUser() {
      if user.authenticated {
        self.performSegueWithIdentifier(tableViewWallSegue, sender: nil)
      }
    }
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
