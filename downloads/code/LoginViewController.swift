import UIKit

class LoginViewController: UIViewController,Controllable{
    
    var eventable: Eventable
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    required init(coder aDecoder: NSCoder) {
        self.eventable = LoginBusinessLogicController()
        super.init(coder: aDecoder)
        self.eventable.controllable = self
    }
    
    func render(key: String!, value: NSObject!) {
        switch(key){
            case "message":
                self.labelMessage.text = value as? String
            default:
                NSLog("No implementation in render for key:\(key)")
        }
    }
    
     func getValue(key: String!) -> NSObject {
        switch(key){
        case "username":
            return self.textFieldUsername.text
        case "password":
            return self.textFieldPassword.text
        default:
            return NSNull()
        }
    }
    
     func goToPage(pageName: String!) {
        switch(pageName){
            case "Home":
                self.performSegueWithIdentifier("HomeIdentifier", sender: self)
            default:
                NSLog("No implementation in goToPage for page:\(pageName)")
        }
    }
    
    @IBAction func onLoginButtonPressed(sender: AnyObject) {
        self.eventable.dispatchEvent("loginButtonPressed", object: nil)
    }
    
    func showAlert(alertMessage: String!) {
        UIAlertView(title: "Alert", message: alertMessage, delegate: nil, cancelButtonTitle: "Okay").show()
    }
    
}

