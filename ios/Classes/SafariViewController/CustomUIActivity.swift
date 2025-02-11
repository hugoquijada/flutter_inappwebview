//
//  CustomUIActivity.swift
//  flutter_inappwebview
//
//  Created by Lorenzo Pichilli on 08/05/22.
//

import Foundation

class CustomUIActivity : UIActivity {
    var viewId: String
    var id: Int64
    var url: URL
    var title: String?
    var type: UIActivity.ActivityType?
    var label: String?
    var image: UIImage?
    
    init(viewId: String, id: Int64, url: URL, title: String?, label: String?, type: UIActivity.ActivityType?, image: UIImage?) {
        self.viewId = viewId
        self.id = id
        self.url = url
        self.title = title
        self.label = label
        self.type = type
        self.image = image
    }

    override class var activityCategory: UIActivity.Category {
        return .action
    }

    override var activityType: UIActivity.ActivityType? {
        return type
    }

    override var activityTitle: String? {
        return label
    }

    override var activityImage: UIImage? {
        return image
    }

    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }

    override func perform() {
        let browser = ChromeSafariBrowserManager.browsers[viewId]
        browser??.channelDelegate?.onChromeSafariBrowserMenuItemActionPerform(id: id, url: url, title: title)
    }
}
