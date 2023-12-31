
//

import UIKit

protocol UserState {
    func handleAuthentication() -> UIViewController
    func handleCreateAd() -> UIViewController
    func handleViewAds() -> UIViewController
}

class UnauthorizedState: UserState {
    func handleAuthentication() -> UIViewController {
        return SigninViewController()
    }

    func handleCreateAd() -> UIViewController {
        return SigninViewController()
    }

    func handleViewAds() -> UIViewController {
        return MainViewController(isSigned: true)
    }
}

class AuthorizedState: UserState {
    func handleAuthentication() -> UIViewController {
        return UserProfileViewController()
    }

    func handleCreateAd() -> UIViewController {
        return CreateAdViewController()
    }

    func handleViewAds() -> UIViewController {
        return MainViewController(isSigned: true)
    }
}
