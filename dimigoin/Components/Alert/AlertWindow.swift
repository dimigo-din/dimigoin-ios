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
            Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
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
        // MARK: 여기서 다시 false로 돌려주네
        self.isPresented.wrappedValue = false
    }
    public func present() {
        UIApplication.shared.windows.first!.rootViewController?.present(self, animated: true, completion: nil)
    }
    public func cancel() {
//        self.isPresented.wrappedValue = false
        self.dismiss(animated: true, completion: nil)
    }
}

extension View {
    public func alert(isPresented: Binding<Bool>, content: () -> Alert) -> some View {
        let alertVC = AlertViewController(alertView: AlertView(visible: isPresented, alert: content()), isPresented: isPresented)
        if isPresented.wrappedValue {
            alertVC.present()
        } else {
            alertVC.cancel()
            alertVC.dismiss(animated: true, completion: nil)
        }
        return self
    }
}
