import UIKit
import Flutter
import FirebaseCore


@main
@objc class AppDelegate: FlutterAppDelegate {
    
    func initFirebase(){
        if FirebaseApp.app() == nil {
            print("initFirebase() | Initializing Firebase...")
            FirebaseApp.configure()
        }
    }
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        self.initFirebase()
        
        return  super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
}
