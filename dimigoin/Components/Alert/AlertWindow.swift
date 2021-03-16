//
//  AlertWindow.swift
//  dimigoin
//
//  Created by 변경민 on 2021/03/10.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI

struct AlertView: View {
    static var currentAlertVCReference: AlertViewController?
    
    @Binding var visible: Bool
    @State var showAlert: Bool = false
    
    let alert: Alert
    
    public var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.black.opacity(0.1))
                .edgesIgnoringSafeArea(.all)
            if showAlert {
                alert.transition(self.alert.animation)
            }
        }.onAppear {
            withAnimation {
                if self.visible {
                    self.showAlert = true
                }
            }
        }
    }
    
}

class AlertViewController: UIHostingController<AlertView> {
    var alertView: AlertView
    var isPresented: Binding<Bool>
    
    init(alertView: AlertView, isPresented: Binding<Bool>) {
        self.alertView = alertView
        self.isPresented = isPresented
        super.init(rootView: self.alertView)
        self.modalPresentationStyle = .overCurrentContext
        self.view.backgroundColor = UIColor.clear
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        self.isPresented.wrappedValue =  false
    }
}

extension View {
    public func alert(isPresented: Binding<Bool>, content: () -> Alert) -> some View {
        let alertView = AlertView(visible: isPresented, alert: content())
        let alertVC = AlertViewController(alertView: alertView, isPresented: isPresented)
        if isPresented.wrappedValue {
            AlertView.currentAlertVCReference = alertVC
            self.topViewController()?.present(alertVC, animated: true, completion: nil)
        } else {
            alertVC.dismiss(animated: true, completion: nil)
        }
        return self
    }
    
    private func topViewController(baseVC: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {
        
        if let nav = baseVC as? UINavigationController {
            return topViewController(baseVC: nav.visibleViewController)
        }
        if let tab = baseVC as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(baseVC: selected)
            }
        }
        if let presented = baseVC?.presentedViewController {
            return topViewController(baseVC: presented)
        }
        return baseVC
    }
}
