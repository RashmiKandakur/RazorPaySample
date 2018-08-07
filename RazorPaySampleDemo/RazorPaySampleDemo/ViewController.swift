//
//  ViewController.swift
//  RazorPaySampleDemo
//
//  Created by Mobility on 30/07/18.
//  Copyright © 2018 Rashmi Kandakur. All rights reserved.
//

import UIKit
import Razorpay

let  KEY_ID = "rzp_test_eDyfVVbkZDErcx"
let SUCCESS_TITLE = "Success!!"
let SUCCESS_MESSAGE = "Your payment was successful. The payment ID is %@"
let FAILURE_TITLE = "Fail!"
let FAILURE_MESSAGE = "Your payment failed due to an error.\nCode: %d\nDescription: %@"
let EXTERNAL_METHOD_TITLE = "External wallet Alert!"
let EXTERNAL_METHOD_MESSAGE = "You selected %@, which is not supported by Razorpay at the moment.\nDo "
//"you want to handle it separately?"
let OK_BUTTON_TITLE = "OK";

class ViewController: UIViewController {
    var razorpay: Razorpay!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //RazorPay Merchant ID AfkDvqN8xxfT8h
        razorpay = Razorpay.initWithKey(KEY_ID, andDelegate: self)
        razorpay.setExternalWalletSelectionDelegate(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func paymentTapped(_ sender: Any) {
        showPaymentForm()
    }
    
    /*
     @{
     @"amount" : @"100",
     @"currency" : @"INR",
     @"description" : @"Fine T-shirt",
     //@"image" : logo,
     @"name" : @"Razorpay",
     @"external" : @{@"wallets" : @[ @"paytm" ]},
     @"prefill" :
     @{@"email" : @"ur email", @"contact" : @"contact number"},
     @"theme" : @{@"color" : @"#3594E2"}
     }
 */
    func showPaymentForm(){
        let image = UIImage(named:"logo")
        let options: [String:Any] = [
            "amount" : "100", //mandatory in paise
            "currency" : "INR",
            "description": "purchase description",
            "image": image!,
            "name": "business or product name",
            "external" : ["wallets" :["paytm"]],
            "prefill": [
                "contact": "contact number",
                "email": "ur email",
            ],
            "theme": [
                "color": "#F37254",
            ]
        ]
        razorpay.open(options)
    }
}

extension ViewController : RazorpayPaymentCompletionProtocol,ExternalWalletSelectionProtocol {
    func onExternalWalletSelected(_ walletName: String, WithPaymentData paymentData: [AnyHashable : Any]?) {
        //For External payments PayTm
        let alertController = UIAlertController(title: EXTERNAL_METHOD_TITLE, message: EXTERNAL_METHOD_MESSAGE, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func onPaymentError(_ code: Int32, description str: String) {
        //Payment Error
        let alertController = UIAlertController(title: "FAILURE", message: str, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        //Success
        let alertController = UIAlertController(title: "SUCCESS", message: "Payment Id \(payment_id)", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}

