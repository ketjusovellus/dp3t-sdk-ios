/*
 * Created by Ubique Innovation AG
 * https://www.ubique.ch
 * Copyright (c) 2020. All rights reserved.
 */

import DP3TSDK_CALIBRATION
import os
import UIKit

func initializeSDK(){
    /// Can be initialized either by:
    /// - using the discovery:
    try! DP3TTracing.initialize(with: .discovery("org.dpppt.demo", enviroment: .dev),
                                mode: .calibration(identifierPrefix: Default.shared.identifierPrefix ?? ""))
    /// - passing the url:
    //try! DP3TTracing.initialize(with: .manual(.init(appId: "org.dpppt.demo", backendBaseUrl: URL(string: "https://demo.dpppt.org/")!)),
    //                            mode: .calibration(identifierPrefix: Default.shared.identifierPrefix ?? ""))
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DP3TTracing.reconnectionDelay = Default.shared.reconnectionDelay

        initializeSDK()
        
        if application.applicationState != .background {
            initWindow()
        }

        switch Default.shared.tracingMode {
        case .none:
            break
        case .active:
            try? DP3TTracing.startTracing()
        case .activeAdvertising:
            try? DP3TTracing.startAdvertising()
        case .activeReceiving:
            try? DP3TTracing.startReceiving()
        }

        return true
    }

    func initWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKey()
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
    }

    func applicationWillEnterForeground(_: UIApplication) {
        if window == nil {
            initWindow()
        }
    }

    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {  
        DP3TTracing.performFetch(with: completionHandler)
    }
}
