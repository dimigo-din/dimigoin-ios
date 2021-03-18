//
//  AlertWindow.swift
//  dimigoin
//
//  Created by 변경민 on 2021/03/10.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI

class AlertViewController: UIHostingController<AlertView> {
    var alertView: AlertView
    
    init(alertView: AlertView) {
        self.alertView = alertView
        super.init(rootView: self.alertView)
        self.modalPresentationStyle = .overCurrentContext
        self.view.backgroundColor = UIColor.clear
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        alertView.showAlert = false
    }
    public func present() {
        UIApplication.shared.windows.first!.rootViewController?.present(self, animated: true, completion: nil)
    }
    public func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
