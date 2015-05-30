import Foundation

class LoginBusinessLogicController: NSObject,Eventable{
    
    var controllable: Controllable?
    
    private var numberOfAttempts = 0
    private let MAXIMUM_NUMBER_OF_ATTEMPTS = 5
    
    func dispatchEvent(eventName: String!, object: NSObject!) {
        switch(eventName){
            case "loginButtonPressed":
                checkLogin()
            default:
            NSLog("NO SUCH EVENT IMPLEMENTED\(eventName)")
        }
    }


    func checkLogin(){
        
        if numberOfAttempts < MAXIMUM_NUMBER_OF_ATTEMPTS {
            let username = controllable?.getValue("username") as! String
            let password = controllable?.getValue("password") as! String
            if isCorrect(username, password: password) {
                controllable?.goToPage?("Home")
            }else{
                controllable?.render("message", value:"Wrong username or password" )
                numberOfAttempts++
                
            }
        }else{
            controllable?.showAlert!("You have exceeded the maximum number of attempts, please try after sometime.")
        }
}

    func isCorrect(username: String,password: String) -> Bool{
        if(username == "batman" && password == "bruce"){
            return true
        }
        
        return false
    }
    
}
