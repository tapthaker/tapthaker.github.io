import XCTest

class LoginBusinessLogicControllerTests: XCTestCase {

    
    var stubbedControllable: StubbedControllable!
    override func setUp() {
        super.setUp()
        let businessController = LoginBusinessLogicController()
        stubbedControllable = StubbedControllable()
        stubbedControllable.eventable = businessController
        businessController.controllable = stubbedControllable
    }
    
    func enterUsernameAndPassword(username: String,password: String){
        stubbedControllable.stubbedGetValue.updateValue(username, forKey: "username")
        stubbedControllable.stubbedGetValue.updateValue(password, forKey: "password")
        stubbedControllable.dispatchEvent("loginButtonPressed", eventValue: nil)
    }
    
    func testLoginFailure(){
        enterUsernameAndPassword("batman", password: "joker")
        
        let lastMessage = stubbedControllable.lastRender["message"] as! String
        XCTAssertEqual(lastMessage, "Wrong username or password", "Should render error message on incorrect password")
    }
    
    func testLoginSuccess(){
        enterUsernameAndPassword("batman", password: "bruce")
        XCTAssertEqual(stubbedControllable.lastPage!, "Home", "Should goTo Home when correct password is enterred")
    }
    
    func testMaximumNumberOfRetries(){
        for i in 0...5{
            enterUsernameAndPassword("batman", password: "joker")
        }
        
        XCTAssertEqual(stubbedControllable.lastAlert!, "You have exceeded the maximum number of attempts, please try after sometime.", "Should alert if exceeded maximum number of attempts")
    }

}
