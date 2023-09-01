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
        
//        let storage = DefaultDrawingStorage()
//        let repository = DefaultDrawingRepository(drawingStorage: storage)
//        let useCase = DefaultDBMultiSyncUseCase(repository: repository)
//        let viewModel = DefaultRuntimeSyncViewModel()
//        let viewController = MultiSyncViewController()
        
        let viewModel = DefaultButtonSyncViewModel(selection: .init(isSelected: false))
        let viewController = ToolPickerViewController()
        
        navigationController.pushViewController(viewController, animated: true)
        
        window?.makeKeyAndVisible()
    }

}

