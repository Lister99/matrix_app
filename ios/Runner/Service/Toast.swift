//
//  Toast.swift
//  Runner
//
//  Created by Joel Asencios on 12/10/24.
//
import SwiftEntryKit
class Toast {
    static func showErrorMessage(title: String, description: String, displayDuration: Double) {
        var attributes: EKAttributes = .bottomToast
        attributes.entryBackground = EKAttributes.BackgroundStyle.color(color: EKColor(.red))
        attributes.displayDuration = displayDuration
        attributes.entryInteraction = .dismiss
        attributes.screenInteraction = .dismiss
        let titleLabel = EKProperty.LabelContent(text: title, style: EKProperty.LabelStyle(font: .systemFont(ofSize: 18, weight: .semibold), color: EKColor(.white)))
        let descriptionLabel = EKProperty.LabelContent(text: description, style: EKProperty.LabelStyle(font: .systemFont(ofSize: 16, weight: .regular), color: EKColor(.white)))
        let simpleMessage = EKSimpleMessage(title: titleLabel, description: descriptionLabel)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        let entry = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: entry, using: attributes)
    }
}

