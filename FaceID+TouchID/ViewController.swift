//
//  ViewController.swift
//  FaceID+TouchID
//
//  Created by Nazar Kopeika on 14.05.2023.
//

import UIKit
import LocalAuthentication /* 8 */

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50)) /* 1 */
        view.addSubview(button) /* 2 */
        button.center = view.center /* 3 */
        button.setTitle("Authorize", for: .normal) /* 4 */
        button.backgroundColor = .systemGreen /* 5 */
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside) /* 6 */

    }
    
    @objc func didTapButton() { /* 7 */
        let context = LAContext() /* 9 */
        var error: NSError? = nil /* 11 */
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                     error: &error) { /* 10 & in out parameter, if comething go wrong, function call will put the error into that error */
            let reason = "Please authorize with rouch id!" /* 14 */
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) { [weak self] success, error in /* 16 add weak self */
                DispatchQueue.main.async { /* 17 */
                    guard success, error == nil else { /* 14 */
                        //failed
                        let alert = UIAlertController(title: "Failed to Authenticate",
                                                      message: "Please try again.   ",
                                                      preferredStyle: .alert) /* 25 */
                        
                        alert.addAction(UIAlertAction(title: "Dismiss",
                                                      style: .cancel,
                                                     handler: nil)) /* 26 */
                        self?.present(alert, animated: true) /* 27 */
                        return /* 15 */
                    }
                }
                //Show other screen, success
                
                    let vc = UIViewController() /* 18 */
                    vc.title = "Welcome" /* 19 */
                    vc.view.backgroundColor = .systemBlue /* 20 */
                DispatchQueue.main.async { /* 28 */
                    self?.present(UINavigationController(rootViewController: vc),
                                  animated: true,
                                  completion: nil) /* 21 */
                }
            } /* 13 */
        }
        else { /* 12 */
            //Can not use
            let alert = UIAlertController(title: "Unavailable",
                                          message: "You cant use this feature",
                                          preferredStyle: .alert) /* 22 */
            
            alert.addAction(UIAlertAction(title: "Dismiss",
                                          style: .cancel,
                                         handler: nil)) /* 23 */
            present(alert, animated: true) /* 24 */
        }
    }


}

