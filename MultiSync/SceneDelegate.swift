//
//  SceneDelegate.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/07/06.
//

import UIKit
import PencilKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        
        window?.rootViewController = navigationController
        
        let viewModel = DefaultCombineMultiSyncViewModel()
        let viewController = CanvasSyncViewController()
        
        navigationController.pushViewController(viewController, animated: true)
        
        window?.makeKeyAndVisible()
    }

}

