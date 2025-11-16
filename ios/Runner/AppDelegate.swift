import UIKit
import Flutter
import FirebaseCore

@main
@objc class AppDelegate: FlutterAppDelegate {
    override init() {
        super.init()
        self.initFirebase()
    }
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        initFirebase()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func initFirebase(){
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }
}
