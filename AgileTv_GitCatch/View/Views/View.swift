//
//  View.swift
//  AgileTv_GitCatch
//
//  Created by Luciano Uchoa on 05/02/25.
//

import UIKit

class View: UIView {
    
    // Views já existentes
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Strings.placeholderUsername
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Strings.buttonTitleSearch, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Novos Labels para exibição de informações
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nome do Usuário: "
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var reposLabel: UILabel = {
        let label = UILabel()
        label.text = "Repositórios: "
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        addSubview(userNameLabel)  // Adicionando o nome do usuário
        addSubview(reposLabel)     // Adicionando os repositórios
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Metrics.textFieldWidthMultiplier),
            textField.heightAnchor.constraint(equalToConstant: Metrics.textFieldHeight),

            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Metrics.buttonTopSpacing),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // Constraints para os labels de nome do usuário e repositórios
            userNameLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            userNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            userNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            
            reposLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 20),
            reposLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            reposLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])
    }

    func setupStyle() {
        backgroundColor = .white
    }
}
