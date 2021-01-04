//
//  HomeView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit
import LocalAuthentication

struct HomeView: View {
    @EnvironmentObject var mealAPI: MealAPI
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var tokenAPI : TokenAPI
    @EnvironmentObject var userAPI: UserAPI
    @Binding var isShowIdCard: Bool
    @State var currentLocation = 0
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                ZStack {
                    VStack {
                        if UIDevice.current.userInterfaceIdiom == .phone {
                            VSpacer(70)
                        } else {
                            VSpacer(20)
                        }
                        Image("school").resizable().aspectRatio(contentMode: .fit).frame(width: UIScreen.screenWidth).opacity(0.3)
                    }
                    HStack {
                        Image("logo").resizable().aspectRatio(contentMode: .fit).frame(height: 38)
                        Spacer()
                        Button(action: {
                            localAuthentication()
//                            showIdCard()
                        }) {
                            // MARK: replace userPhoto-sample to userImage when backend ready
                            Image("userPhoto-sample")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 38)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color("accent"), lineWidth: 2)
                                )
                        }
                    }.horizonPadding()
                }
                VSpacer(15)
                LocationSelectionView(currentLocation: $currentLocation)
                Spacer()
                Text("오늘의 급식").font(Font.custom("NotoSansKR-Bold", size: 20)).horizonPadding()
                MealPagerView()
                    .environmentObject(mealAPI)
            }
        }
    }
    func showIdCard() {
        withAnimation(.spring()) {
            self.isShowIdCard = true
        }
    }
    func dismissIdCard() {
        withAnimation(.spring()) {
            self.isShowIdCard = false
        }
    }
    func localAuthentication() -> Void {
        let authContext = LAContext()
        
        var error: NSError?
        
        var description: String!
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            switch authContext.biometryType {
            case .faceID:
                description = "계정 정보를 열람하기 위해서 Face ID로 인증 합니다."
                break
            case .touchID:
                description = "계정 정보를 열람하기 위해서 Touch ID로 인증 사용합니다."
                break
            case .none:
                description = "계정 정보를 열람하기 위해서는 로그인하십시오."
                break
            }
            
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: description) { (success, error) in
                
                if success {
                    print("인증 성공")
                } else {
                    print("인증 실패")
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
                
            }
            
        }  else {
            // Touch ID・Face ID를 사용할 수없는 경우
            let errorDescription = error?.userInfo["NSLocalizedDescription"] ?? ""
            print(errorDescription)
            description = "계정 정보를 열람하기 위해서는 로그인하십시오."
            
            let alertController = UIAlertController(title: "Authentication Required", message: description, preferredStyle: .alert)
            weak var usernameTextField: UITextField!
            alertController.addTextField(configurationHandler: { textField in
                textField.placeholder = "User ID"
                usernameTextField = textField
            })
            weak var passwordTextField: UITextField!
            alertController.addTextField(configurationHandler: { textField in
                textField.placeholder = "Password"
                textField.isSecureTextEntry = true
                passwordTextField = textField
            })
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Log In", style: .destructive, handler: { action in
                // 를
                print(usernameTextField.text! + "\n" + passwordTextField.text!)
            }))
//            self.present(alertController, animated: true, completion: nil)
        }
        
        


    }
}


