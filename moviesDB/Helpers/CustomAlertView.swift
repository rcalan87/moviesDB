//
//  CustomAlertView.swift
//  moviesDB
//
//  Created by Alan Rodriguez on 27/11/24.
//

import SwiftUI

enum AlertType {
    case success
    case error(title: String, message: String = "")
    
    func title() -> String {
        switch self {
        case .success:
            return "Success"
        case .error(title: let title, _):
            return title
        }
    }
    
    func message() -> String {
        switch self {
        case .success:
            return "This is a default success message"
        case .error(_, message: let message):
            return message
        }
    }
    
    var leftActionText: String {
        switch self {
        case .success:
            return "Ok"
        case .error(_, _):
            return "Ok"
        }
    }
    
    var rightActionText: String {
        switch self {
        case .success:
            return "Cancel"
        case .error(_, _):
            return "Cancel"
        }
    }
}

public struct CustomAlertView: View {
    @Binding var presentAlert: Bool
    @State var alertType: AlertType = .success
    var leftButtonAction: (() -> ())?
    var rightButtonAction: (() -> ())?
    
    public var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if alertType.title() != "" {
                    Text(alertType.title())
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(._900)
                        .multilineTextAlignment(.center)
                        .frame(height: 25)
                        .padding(.top, 16)
                        .padding(.bottom, 8)
                        .padding(.horizontal, 16)
                }
                
                Text(alertType.message())
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .font(.system(size: 14))
                    .foregroundColor(._700)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    .minimumScaleFactor(0.5)
                
                HStack(spacing: 0) {
                    if (!alertType.leftActionText.isEmpty) {
                        Button {
                            leftButtonAction?()
                        } label: {
                            Text(alertType.leftActionText)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(._900)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                        .background(.green)
                        .cornerRadius(30)
                    }
                    
                    Button {
                        rightButtonAction?()
                    } label: {
                        Text(alertType.rightActionText)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(._700)
                            .multilineTextAlignment(.center)
                            .padding(15)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    }
                    .background(._400)
                    .cornerRadius(30)
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 55)
                .padding([.horizontal, .vertical], .zero)
                
            }
            
        }
        .frame(width: 270, height: 220)
        .background(.white)
        .cornerRadius(8)
    }
}

#Preview {
    struct CustomAlertViewPreviewContainer : View {
        @State private var value = false
        
        var body: some View {
            CustomAlertView(presentAlert: $value)
        }
    }
    
    return CustomAlertViewPreviewContainer()
}
