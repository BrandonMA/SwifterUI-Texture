//
//  SFChatController.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 10/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit
import MobileCoreServices

open class SFChatController: SFViewController<SFChatNode>, ASCollectionDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Instance Properties
    
    open var messages: [SFMessage] = []
    
    // MARK: - Initializers
    
    public override init(SFNode: SFChatNode, automaticallyAdjustsColorStyle: Bool) {
        super.init(SFNode: SFNode, automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        
        SFNode.collectionNode.dataSource = self
        SFNode.bottomBar.textField.textField.delegate = self
        SFNode.bottomBar.imageButton.addTarget(self, action: #selector(imageButtonDidTouch), forControlEvents: ASControlNodeEvent.touchUpInside)
        SFNode.collectionNode.view.keyboardDismissMode = .interactive
        SFNode.bottomBar.sendButton.addTarget(self, action: #selector(sendButtonDidTouch), forControlEvents: ASControlNodeEvent.touchUpInside)
    }
    
    required convenience public init(automaticallyAdjustsColorStyle: Bool) {
        self.init(SFNode: SFChatNode(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle), automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.deregisterFromKeyboardNotifications()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.SFNode.collectionNode.scrollDown(inSection: 0)
        registerForKeyboardNotifications()
    }
    
    open func keyboardWillShow(notification: NSNotification) {
        updateKeyboardHeight(notification: notification)
        self.SFNode.transitionLayout(withAnimation: true, shouldMeasureAsync: false, measurementCompletion: nil)
        self.SFNode.collectionNode.scrollDown(inSection: 0)
    }
    
    open func keyboardWillHide(notification: NSNotification) {
        updateKeyboardHeight(notification: notification)
        self.SFNode.transitionLayout(withAnimation: true, shouldMeasureAsync: true, measurementCompletion: nil)
    }
    
    @objc open func sendButtonDidTouch() {
        if self.SFNode.bottomBar.textField.text != "" {
            send(message: self.SFNode.bottomBar.textField.text)
        }
    }
    
    @objc open func imageButtonDidTouch() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.mediaTypes = [kUTTypeImage as String]
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: - ASCollectionDataSource
    
    open func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    open func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    open func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            var cell: SFChatCell = SFChatCell(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
            
            let message = self.messages[indexPath.row]
            
            if let text = message.text {
                cell = SFChatCell(withText: text, automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
            } else if let image = message.image {
                cell = SFChatCell(withImage: image, automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
            }
            cell.sender = message.sender
            
            return cell
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if self.SFNode.bottomBar.textField.text != "" {
            send(message: self.SFNode.bottomBar.textField.text)
        } else {
            self.SFNode.view.endEditing(true)
            self.SFNode.keyboardHeight = 0
            self.SFNode.transitionLayout(withAnimation: true, shouldMeasureAsync: true, measurementCompletion: nil)
        }
        
        return true
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let originalImage = info["UIImagePickerControllerOriginalImage"] {
            selectedImageFromPicker = originalImage as? UIImage
        }
        
        send(image: selectedImageFromPicker)
        
        dismiss(animated: true, completion: nil)
    }
    
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.SFNode.collectionNode.invalidateCalculatedLayout()
    }
}

extension SFChatController {
    
    // registerForKeyboardNotifications: Adding notifies on keyboard appearing
    open func registerForKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // deregisterFromKeyboardNotifications: Removing notifies on keyboard appearing
    open func deregisterFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    open func updateKeyboardHeight(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.SFNode.keyboardHeight = keyboardRectangle.height
        }
    }
    
    open func send(message: String) {
        let message = SFMessage(image: nil, text: message)
        self.messages.append(message)
        self.SFNode.bottomBar.textField.text = ""
        self.SFNode.collectionNode.insertLastItem(inSection: 0)
        self.SFNode.collectionNode.scrollDown(inSection: 0)
    }
    
    open func send(image: UIImage?) {
        let message = SFMessage(image: image, text: nil)
        self.messages.append(message)
        self.SFNode.collectionNode.insertLastItem(inSection: 0)
        self.SFNode.collectionNode.scrollDown(inSection: 0)
    }
}






