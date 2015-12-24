import UIKit
import Parse


class RegisterViewController: UIViewController {
  
  @IBOutlet weak var userTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet var emailTextField: UITextField!
  
let scrollViewWallSegue = "SignupSuccesful"
  let tableViewWallSegue = "SignupSuccesfulTable"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    }

    
  @IBAction func signUpPressed(sender: AnyObject) {
    let user = PFUser()
    user.username = userTextField.text
    user.password = passwordTextField.text
    user.email = emailTextField.text
    if user.email == "" {
        let alert = UIAlertController(title: "Error !", message: "Please enter an email address", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
        emailTextField.highlighted = true
    }
    else{
        user.signUpInBackgroundWithBlock { succeeded, error in
            if (succeeded) {
                self.performSegueWithIdentifier(self.tableViewWallSegue, sender: nil)
            } else if let error = error {
                self.showErrorView(error)
            }
        }
    }
  }
    
    
}
