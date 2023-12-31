import Foundation
import UIKit

final class StorageManager {
    static let shared = StorageManager()

    let facade: NetworkFacade = NetworkFacade()
    private let baseURL = "https://fastapi-xhpv.onrender.com/Ads/"

    private init() {}

    func uploadImage(image: UIImage?, adId: String) {
        facade.uploadImage(image: image, adId: adId)
    }
}
