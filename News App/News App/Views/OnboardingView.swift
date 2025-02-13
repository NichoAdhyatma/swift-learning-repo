//
//  OnboardingView.swift
//  News App
//
//  Created by nicho@mac on 05/02/25.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            HStack(spacing: 4) {
                Text("BUY")
                    .font(Font.custom("Readex Pro", size: 16).weight(.medium))
                    .lineSpacing(18)
                    .foregroundColor(.white)
            }
            .padding(EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24))
            .frame(width: 156, height: 48)
            .background(Color(red: 0.06, green: 0.31, blue: 0.98))
            .cornerRadius(12)
            
            HStack(spacing: 10) {
                Text("ETH/USD")
                    .font(Font.custom("Readex Pro", size: 14))
                    .lineSpacing(16)
                    .foregroundColor(.white)
            }
            .padding(EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8))
            .frame(width: 80, height: 28)
            .background(Color(red: 0.18, green: 0.40, blue: 0.96))
            .cornerRadius(8)
            .shadow(
                color: Color(red: 0.18, green: 0.40, blue: 0.96, opacity: 0.12), radius: 4, y: 3
            )
            
            HStack(spacing: 8) {
                ZStack() {

                }
                .frame(width: 24, height: 24)
                Text("Continue with Facebook")
                    .font(Font.custom("Readex Pro", size: 14))
                    .lineSpacing(16)
                    .foregroundColor(Color(red: 0.07, green: 0.09, blue: 0.23))
            }
            .padding(EdgeInsets(top: 12, leading: 14, bottom: 12, trailing: 14))
            .frame(width: 343, height: 48)
            .background(.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .inset(by: 0.50)
                    .stroke(Color(red: 0.84, green: 0.85, blue: 0.89), lineWidth: 0.50)
            )
        }
        
    }
}

#Preview {
    OnboardingView()
}
