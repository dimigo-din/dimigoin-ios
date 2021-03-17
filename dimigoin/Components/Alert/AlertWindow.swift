//
//  AlertWindow.swift
//  dimigoin
//
//  Created by 변경민 on 2021/03/10.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI


class AlertViewController: UIHostingController<Alert> {
    var alertView: Alert
//    var isPresented: Binding<Bool>
    
    init(alertView: Alert) {
        self.alertView = alertView
//        self.isPresented = isPresented
        super.init(rootView: self.alertView)
        self.modalPresentationStyle = .overCurrentContext
        self.view.backgroundColor = UIColor.clear
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        // MARK: 여기서 다시 false로 돌려주네
//        self.isPresented.wrappedValue = false
        alertView.showAlert = false
    }
    public func present() {
        UIApplication.shared.windows.first!.rootViewController?.present(self, animated: true, completion: nil)
    }
    public func dismiss() {
//        self.isPresented.wrappedValue = false
        self.dismiss(animated: true, completion: nil)
    }
}
