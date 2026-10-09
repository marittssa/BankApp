
import XCTest

final class BankingFlowTests: BaseClass {

    private func createSteps() -> EasyBankSteps {
        let page = EasyBankPage(app: app)
        return EasyBankSteps(page: page)
    }


    func testInvalidEmailFormat() {

        let steps = createSteps()

        steps.openLoginScreen()

        steps.login(
            email: "invalid-email",
            password: "WrongPassword123!"
        )

        steps.verifyLoginError(
            containing: "badly formatted"
        )
    }


    func testInvalidCredentials() {

        let steps = createSteps()

        let email =
            "unknown-\(UUID().uuidString)@example.com"

        steps.openLoginScreen()

        steps.login(
            email: email,
            password: "WrongPassword123!"
        )

        steps.verifyLoginError(
            containing: "malformed or has expired"
        )
    }


    func testRegistrationLogoutAndLoginAgain() {

        let steps = createSteps()

        let uniqueID = UUID().uuidString
            .replacingOccurrences(of: "-", with: "")
            .lowercased()

        let email = "easybank-\(uniqueID)@example.com"
        let password = "Test@123456"

        steps.openRegistrationScreen()

        steps.register(
            email: email,
            password: password
        )

        steps.verifyHomeScreen()

        steps.logout()

        steps.login(
            email: email,
            password: password
        )

        steps.verifyHomeScreen()
    }
}
