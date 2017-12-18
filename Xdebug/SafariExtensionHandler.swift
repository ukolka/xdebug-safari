//
//  SafariExtensionHandler.swift
//  Xdebug
//
//  Created by Mykola Bespaliuk on 12/14/17.
//  Copyright © 2017 Mykola Bespaliuk. All rights reserved.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    static var isActive = false
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        page.getPropertiesWithCompletionHandler { properties in
            SafariExtensionHandler.isActive = userInfo!["isActive"]! as? Int == 1 ? true : false
            SFSafariApplication.setToolbarItemsNeedUpdate()
        }
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        window.getActiveTab { (tab) in
            tab?.getActivePage(completionHandler: { (page) in
                
                SafariExtensionHandler.isActive = !SafariExtensionHandler.isActive

                page!.dispatchMessageToScript(withName: "toggleXdebug", userInfo: ["isActive": SafariExtensionHandler.isActive])
                
                window.getToolbarItem { (toolbar) in
                    toolbar!.setBadgeText(SafariExtensionHandler.isActive ? "ON" : nil)
                }
            })
        }
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        validationHandler(true, "")
        window.getToolbarItem { (toolbar) in
            toolbar!.setBadgeText(SafariExtensionHandler.isActive ? "ON" : nil)
        }
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        return SafariExtensionViewController.shared
    }

}
