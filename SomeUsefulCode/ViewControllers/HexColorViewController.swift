//
//  HexColorViewController.swift
//  SomeUsefulCode
//
//  Created by Hoang Tung on 2/12/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import UIKit

class HexColorViewController: UIViewController {
  
  let colorView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .systemFill
    return view
  }()
  
  let inputTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor.systemFill.cgColor
    textField.textAlignment = .center
    textField.font = .systemFont(ofSize: 24)
    return textField
  }()
  
  let changeButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Show", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 8
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupView()
    setupLayout()
    hideKeyboardWhenTappedAround()
    setupButton()
  }
  
  func setupView() {
    view.addSubview(colorView)
    view.addSubview(inputTextField)
    view.addSubview(changeButton)
  }
  
  func setupLayout() {
    colorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    colorView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    colorView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
    colorView.heightAnchor.constraint(equalTo: colorView.widthAnchor, multiplier: 1).isActive = true
    
    inputTextField.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 50).isActive = true
    inputTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
    inputTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    inputTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    changeButton.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 16).isActive = true
    changeButton.leadingAnchor.constraint(equalTo: inputTextField.leadingAnchor, constant: 0).isActive = true
    changeButton.trailingAnchor.constraint(equalTo: inputTextField.trailingAnchor, constant: 0).isActive = true
    changeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
  }
  
  func setupButton() {
    changeButton.addTarget(self, action: #selector(displayColor), for: .touchUpInside)
  }
  
  @objc func displayColor() {
    colorView.backgroundColor = hexStringToUIColor(hex: inputTextField.text ?? "")
  }
  
}

extension HexColorViewController {
  func hexStringToUIColor(hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
      cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
      return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
}
