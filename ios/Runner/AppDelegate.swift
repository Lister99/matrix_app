import UIKit
import Flutter


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let matrixChannel = FlutterMethodChannel(name: Constants.MATRIX_CHANNEL,
                                                 binaryMessenger: controller.binaryMessenger)
        matrixChannel.setMethodCallHandler({(call, flutterResult) in
            if call.method == Constants.SHOW_ORIGINAL_MATRIX {
                let arguments : MatrixData = MatrixData(call.arguments as! String)
                BottomSheet.showMatrixDialog(
                    title: arguments.title,
                    description: arguments.getStringMatrix(),
                    buttonTitle: arguments.buttonText)}
            else if call.method == Constants.SHOW_ERROR_MESSAGE_MATRIX {
                let arguments : ErrorMessage = ErrorMessage(call.arguments as! String)
                Toast.showErrorMessage(title: arguments.title, description:arguments.description, displayDuration: arguments.displayDuration)
            }
        })
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
}
