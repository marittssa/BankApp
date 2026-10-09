
import XCTest

final class EasyBankSteps {

    private let page: EasyBankPage

    init(page: EasyBankPage) {
        self.page = page
    }


    private func tapElement(
        _ element: XCUIElement
    ) {
        XCTAssertTrue(
            element.waitForExistence(timeout: 15),
            "Element did not appear: \(element)"
        )

        element.tap()
    }

    private func enterText(
        _ text: String,
        into field: XCUIElement,
        handleStrongPassword: Bool = false
    ) {
        XCTAssertTrue(
            field.waitForExistence(timeout: 15),
            "Input field did not appear: \(field)"
        )

        field.tap()

        if handleStrongPassword {
            let closeButton = page.app.buttons["Close"]

            if closeButton.waitForExistence(timeout: 1)
                && closeButton.isHittable {
                closeButton.tap()
            }
        }

        field.typeText(text)
    }


    func openLoginScreen() {

        tapElement(page.onboardingLoginButton)

        XCTAssertTrue(
            page.loginEmailField.waitForExistence(
                timeout: 15
            ),
            "Login screen did not open"
        )
    }


    func openRegistrationScreen() {

        tapElement(page.onboardingRegisterButton)

        XCTAssertTrue(
            page.registrationEmailField.waitForExistence(
                timeout: 15
            ),
            "Registration screen did not open"
        )
    }


    func login(
        email: String,
        password: String
    ) {

        enterText(
            email,
            into: page.loginEmailField
        )

        enterText(
            password,
            into: page.loginPasswordField
        )

        tapElement(page.loginSubmitButton)
    }


    func verifyLoginError(
        containing expectedMessage: String
    ) {
        let error = page.loginErrorMessage

        XCTAssertTrue(
            error.waitForExistence(timeout: 15),
            "Login error was not displayed"
        )

        XCTAssertTrue(
            error.label.contains(expectedMessage),
            """
            Expected error containing: \(expectedMessage)
            Actual error: \(error.label)
            """
        )
    }


    func register(
        email: String,
        password: String
    ) {

        enterText(
            email,
            into: page.registrationEmailField
        )

        enterText(
            password,
            into: page.registrationPasswordField,
            handleStrongPassword: true
        )

        enterText(
            password,
            into: page.registrationRepeatPasswordField,
            handleStrongPassword: true
        )

        tapElement(page.registrationSubmitButton)
    }


    func verifyHomeScreen() {

        XCTAssertTrue(
            page.sendMoneyButton.waitForExistence(
                timeout: 20
            ),
            "Home screen was not displayed"
        )
    }


    func logout() {

        tapElement(page.logoutButton)

        XCTAssertTrue(
            page.logoutAlert.waitForExistence(
                timeout: 15
            ),
            "Logout confirmation did not appear"
        )

        tapElement(page.confirmLogoutButton)

        XCTAssertTrue(
            page.loginEmailField.waitForExistence(
                timeout: 15
            ),
            "Login screen did not appear after logout"
        )
    }
}
