//
//  KKSwiftVC.swift
//  KKTest
//
//  Created by ZhuKangKang on 2021/1/20.
//  Copyright © 2021 ZKKMBP. All rights reserved.
//

import UIKit

class KKSwiftVC: UIViewController {

    @IBOutlet weak var logBtnAction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.yellow;
        
    }

    @IBAction func onLogButtonAction(_ sender: UIButton) {
        let secVC = KKSecondVC()
        self.navigationController?.pushViewController(secVC, animated: true)
    }
    
    @objc func onSwiftLog() -> Bool {
        print("朱康康")
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
