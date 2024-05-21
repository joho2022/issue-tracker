//
//  LabelEditorViewController.swift
//  issue-tracker-01
//
//  Created by 조호근 on 5/20/24.
//

import UIKit

class LabelEditorViewController: UIViewController {
    
    static let identifier: String = "LabelEditorViewController"
    
    var labelViewModel: LabelViewModel!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var backgroundLabel: UILabel!
    @IBOutlet weak var backgroundValueLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelLabel: LabelEditorPaddingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelViewModel = LabelViewModel.shared
        
        self.containerView.layer.cornerRadius = 12
        configureFont()
        configureNavigationBar()
        configureTextField()
        setupLayout()
    }
    
    private func setupLayout() {
        self.labelLabel.layer.cornerRadius = 12
        self.labelLabel.clipsToBounds = true
    }
    
    private func configureFont() {
        self.titleLabel.applyStyle(fontManager: FontManager(weight: .medium, size: .large), textColor: .gray800)
        self.descriptionLabel.applyStyle(fontManager: FontManager(weight: .medium, size: .large), textColor: .gray800)
        self.backgroundLabel.applyStyle(fontManager: FontManager(weight: .medium, size: .large), textColor: .gray800)
        self.backgroundValueLabel.applyStyle(fontManager: FontManager(weight: .medium, size: .large), textColor: .gray900)
        self.labelLabel.applyStyle(fontManager: FontManager(weight: .medium, size: .small), textColor: .gray50)
    }
    
    private func configureNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backBtnTapped)
        )
        navigationItem.leftBarButtonItem = backButton
        
        let saveButton = UIBarButtonItem(title: "저장",
                                         style: .plain,
                                         target: self,
                                         action: #selector(saveBtnTapped)
        )
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc private func backBtnTapped() {
        navigationController?.dismiss(animated: true)
    }
    
    @objc private func saveBtnTapped() {
        guard let name = titleField.text, !name.isEmpty,
              let description = descriptionField.text,
              let color = backgroundValueLabel.text, !color.isEmpty else {
            return
        }
        
        let labelRequest = LabelRequest(name: name, description: description, color: color)
        labelViewModel.createLabel(labelRequest: labelRequest) { success in
            if success {
                print("[\(labelRequest.name)]: 레이블 생성!")
                self.navigationController?.dismiss(animated: true)
            } else {
                print("레이블 생성실패")
            }
        }
    }
    
    private func configureTextField() {
        titleField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        validateFields()
        if textField == titleField {
            labelLabel.text = titleField.text
        }
    }
    
    @IBAction func colorBtnTapped(_ sender: Any) {
        let randomHexColor = generateRandomHexColor()
        let color = UIColor(hex: randomHexColor)
        backgroundValueLabel.text = randomHexColor
        labelLabel.backgroundColor = color
        labelLabel.text = titleField.text
        labelLabel.textColor = color.isDarkColor ? .gray50 : .gray900
        validateFields()
    }
    
    private func validateFields() {
        let isTitleValid = !(titleField.text?.isEmpty ?? true)
        let isBackgroundValid = !(backgroundValueLabel.text?.isEmpty ?? true)
        navigationItem.rightBarButtonItem?.isEnabled = isTitleValid && isBackgroundValid
    }
    
    private func generateRandomHexColor() -> String {
        let red = Int.random(in: 0...255)
        let green = Int.random(in: 0...255)
        let blue = Int.random(in: 0...255)
        return String(format: "#%02X%02X%02X", red, green, blue)
    }
}
