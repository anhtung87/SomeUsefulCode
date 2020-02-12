//
//  HideKeyboardViewController.swift
//  SomeUsefulCode
//
//  Created by Hoang Tung on 2/12/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import UIKit

class HideKeyboardViewController: UIViewController {
  
  let inputTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.layer.borderColor = UIColor.systemBlue.cgColor
    textField.layer.borderWidth = 1
    textField.layer.cornerRadius = 25
    // tạo lề cho phần nhập input
    return textField
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupView()
    setupLayout()
    // add hideKeyboardFunction
    hideKeyboardWhenTappedAround()
  }
  
  
  func setupView() {
    view.addSubview(inputTextField)
  }
  
  func setupLayout() {
    inputTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
    inputTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    inputTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    inputTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
  }
}

// MARK: setup hide keyboard function
extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}

