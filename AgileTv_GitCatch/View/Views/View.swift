//
//  View.swift
//  AgileTv_GitCatch
//
//  Created by Luciano Uchoa on 05/02/25.
//

import UIKit

class View: UIView {

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Strings.placeholderUsername
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Strings.buttonTitleSearch, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension View: ViewCode {
    func addSubviews() {
        addSubview(textField)
        addSubview(button)
    }

    func setupConstraints() {
            NSLayoutConstraint.activate([
                textField.centerXAnchor.constraint(equalTo: centerXAnchor),
                textField.centerYAnchor.constraint(equalTo: centerYAnchor),
                textField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Metrics.textFieldWidthMultiplier),
                textField.heightAnchor.constraint(equalToConstant: Metrics.textFieldHeight),

                button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Metrics.buttonTopSpacing),
                button.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        }

    func setupStyle() {
        backgroundColor = .white
    }
}
