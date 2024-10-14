//
//  BottomSheet.swift
//  Runner
//
//  Created by Joel Asencios on 12/10/24.
//
import SwiftEntryKit
class BottomSheet {
    static func showMatrixDialog(title: String, description: String, buttonTitle: String) {
        var attributes: EKAttributes = .bottomToast
        attributes.entryBackground = .color(color: EKColor.white)
        attributes.roundCorners = .top(radius: 12)
        
        attributes.displayDuration = .infinity
        attributes.entryInteraction = .absorbTouches
        attributes.screenInteraction = .absorbTouches
        
        let titleLabel = EKProperty.LabelContent(
            text: title,
            style: EKProperty.LabelStyle(
                font: .systemFont(ofSize: 18, weight: .semibold),
                color: EKColor(.black),
                alignment: .center,
                numberOfLines: 1
            )
        )
        
        let descriptionLabel = EKProperty.LabelContent(
            text: description,
            style: EKProperty.LabelStyle(
                font: .systemFont(ofSize: 16, weight: .regular),
                color: .black,
                alignment: .center,
                numberOfLines: 0
            )
        )
        
        let buttonLabel = EKProperty.LabelContent(
            text: buttonTitle,
            style: EKProperty.LabelStyle(
                font: .systemFont(ofSize: 16, weight: .semibold),
                color: .white,
                alignment: .center,
                numberOfLines: 1
            )
        )
        
        let button = EKProperty.ButtonContent(
            label: buttonLabel,
            backgroundColor: .black,
            highlightedBackgroundColor: .white,
            contentEdgeInset: 8
        )
        
        let popUpMessage = EKPopUpMessage(
            title: titleLabel,
            description: descriptionLabel,
            button: button) {
                SwiftEntryKit.dismiss()
            }
        
        let entry = EKPopUpMessageView(with: popUpMessage)
        SwiftEntryKit.display(entry: entry, using: attributes)
    }
}
