//
//  DisplayedContentViewController.swift
//  SomeUsefulCode
//
//  Created by Hoang Tung on 2/14/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import UIKit

// Các bước thực hiện:
// 1. Dựng scrollView.
// 2. delegate viewController với textField
// 3. gọi func textFieldDidBeginEditing để trigger event user chạm vào textField
// 4. Sử dụng Notification để thông báo khi keyboard hiện lên.
// 5. ViewController lấy giá trị height của keyboard.
// 6. Tính toán giá trị khoảng cách cần thay đổi.
// 7. thay đổi contentOffset của scrollView theo giá trị đã tính.

class DisplayedContentViewController: UIViewController {
  
  var screenLocationCheckpoint: CGPoint?
  
  let backgroundView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    return view
  }()
  
  let screenScrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.contentSize = CGSize(width: UIScreen.main.bounds.maxX, height: UIScreen.main.bounds.maxY * 2)
    scrollView.backgroundColor = .systemPurple
    return scrollView
  }()
  
  let screenView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .systemTeal
    return view
  }()
  
  let exampleTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.backgroundColor = .white
    return textField
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupLayout()
    setupTextField()
    hideKeyboardWhenTappedAround()
  }
  
  func setupView() {
    view.addSubview(backgroundView)
    backgroundView.addSubview(screenScrollView)
    screenScrollView.addSubview(screenView)
    screenView.addSubview(exampleTextField)
  }
  
  func setupLayout() {
    backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    
    screenScrollView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 0).isActive = true
    screenScrollView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 0).isActive = true
    screenScrollView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 0).isActive = true
    screenScrollView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 0).isActive = true
    
    screenView.topAnchor.constraint(equalTo: screenScrollView.topAnchor, constant: 0).isActive = true
    screenView.leadingAnchor.constraint(equalTo: screenScrollView.leadingAnchor, constant: 0).isActive = true
    screenView.widthAnchor.constraint(equalTo: backgroundView.widthAnchor).isActive = true
    screenView.heightAnchor.constraint(equalTo: backgroundView.heightAnchor).isActive = true
    
    exampleTextField.centerXAnchor.constraint(equalTo: screenView.centerXAnchor, constant: 0).isActive = true
    exampleTextField.widthAnchor.constraint(equalTo: screenView.widthAnchor, multiplier: 0.8).isActive = true
    exampleTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    exampleTextField.centerYAnchor.constraint(equalTo: screenView.centerYAnchor,
                                              constant: UIScreen.main.bounds.maxY / 4).isActive = true
  }
  
  func setupTextField() {
    exampleTextField.delegate = self
  }
  
  @objc func keyboardWillShow(_ notification: Notification) {
    if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      let keyboardRectangle = keyboardFrame.cgRectValue
      let keyboardHeight = keyboardRectangle.height
      reloadLayout(keyboardHeight)
    }
  }
  
  func keyboardDidEnd() {
    UIView.animate(withDuration: 0.28, animations: {
      self.screenScrollView.contentOffset = self.screenLocationCheckpoint!
    })
  }
  
  func reloadLayout(_ height: CGFloat) {
    let bottomPadding = UIScreen.main.bounds.maxY - exampleTextField.frame.maxY - exampleTextField.bounds.maxY
    screenScrollView.contentOffset = CGPoint(x: 0, y: CGFloat(height - bottomPadding))
  }
}

extension DisplayedContentViewController: UITextFieldDelegate {
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    screenLocationCheckpoint = screenScrollView.contentOffset
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    keyboardDidEnd()
  }
}
