//
//  ColorPickerController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 30/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class ColorPickerNode: SFDisplayNode {
    
    lazy var redLabel: SFLabelNode = {
        let label = SFLabelNode(automaticallyAdjustsColorStyle: false)
        label.text = "Red"
        label.textColor = SFAssets.red
        label.font = UIFont.boldSystemFont(ofSize: 19)
        return label
    }()
    
    lazy var redColorSlider: SFSliderNode = {
        let slider = SFSliderNode(automaticallyAdjustsColorStyle: true)
        slider.slider.minimumTrackTintColor = SFAssets.red
        slider.slider.maximumValue = 255
        return slider
    }()
    
    lazy var greenLabel: SFLabelNode = {
        let label = SFLabelNode(automaticallyAdjustsColorStyle: false)
        label.text = "Green"
        label.textColor = SFAssets.green
        label.font = UIFont.boldSystemFont(ofSize: 19)
        return label
    }()
    
    lazy var greenColorSlider: SFSliderNode = {
        let slider = SFSliderNode(automaticallyAdjustsColorStyle: true)
        slider.slider.minimumTrackTintColor = SFAssets.green
        slider.slider.maximumValue = 255
        return slider
    }()
    
    lazy var blueLabel: SFLabelNode = {
        let label = SFLabelNode(automaticallyAdjustsColorStyle: false)
        label.text = "Blue"
        label.textColor = SFAssets.blue
        label.font = UIFont.boldSystemFont(ofSize: 19)
        return label
    }()
    
    lazy var blueColorSlider: SFSliderNode = {
        let slider = SFSliderNode(automaticallyAdjustsColorStyle: true)
        slider.slider.minimumTrackTintColor = SFAssets.blue
        slider.slider.maximumValue = 255
        return slider
    }()
    
    lazy var textField: SFTextField = {
        let textField = SFTextField(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        textField.placeholder = "000000"
        textField.leftPadding = 12
        textField.textField.autocapitalizationType = .allCharacters
        textField.textField.autocorrectionType = .no
        return textField
    }()
    
    lazy var colorNode: SFDisplayNode = {
        let node = SFDisplayNode(automaticallyAdjustsColorStyle: false)
        node.backgroundColor = UIColor(red: CGFloat(self.redColorSlider.value), green: CGFloat(self.greenColorSlider.value), blue: CGFloat(self.blueColorSlider.value), alpha: 1.0)
        node.borderColor = SFAssets.gray.cgColor
        node.borderWidth = 8
        node.cornerRadius = 4
        return node
    }()
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        redLabel.style.width = ASDimension(unit: .fraction, value: 1/3)
        blueLabel.style.width = ASDimension(unit: .fraction, value: 1/3)
        greenLabel.style.width = ASDimension(unit: .fraction, value: 1/3)
        
        colorNode.style.width = ASDimension(unit: .fraction, value: 1)
        colorNode.style.flexGrow = 1.0
        colorNode.style.flexShrink = 1.0
        
        let redStack = ASStackLayoutSpec(direction: .horizontal, spacing: 16, justifyContent: .start, alignItems: .center, children: [redLabel, redColorSlider])
        redStack.style.width = ASDimension(unit: .fraction, value: 1)
        
        let greenStack = ASStackLayoutSpec(direction: .horizontal, spacing: 16, justifyContent: .start, alignItems: .center, children: [greenLabel, greenColorSlider])
        greenStack.style.width = ASDimension(unit: .fraction, value: 1)
        
        let blueStack = ASStackLayoutSpec(direction: .horizontal, spacing: 16, justifyContent: .start, alignItems: .center, children: [blueLabel, blueColorSlider])
        blueStack.style.width = ASDimension(unit: .fraction, value: 1)
        
        let stack = ASStackLayoutSpec(direction: .vertical, spacing: 32, justifyContent: .start, alignItems: .start, children: [redStack, greenStack, blueStack, textField, colorNode])
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 32, left: 32, bottom: 32, right: 32), child: stack)
    }
    
}

class ColorPickerController: SFViewController<ColorPickerNode>, UITextFieldDelegate {
    
    init() {
        super.init(SFNode: ColorPickerNode(), automaticallyAdjustsColorStyle: true)
        self.SFNode.redColorSlider.add(target: self, action: #selector(sliderValueChanged), for: .valueChanged)
        self.SFNode.greenColorSlider.add(target: self, action: #selector(sliderValueChanged), for: .valueChanged)
        self.SFNode.blueColorSlider.add(target: self, action: #selector(sliderValueChanged), for: .valueChanged)
        self.SFNode.textField.delegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func sliderValueChanged() {
        self.SFNode.colorNode.backgroundColor = UIColor(r: CGFloat(self.SFNode.redColorSlider.value), g: CGFloat(self.SFNode.greenColorSlider.value), b: CGFloat(self.SFNode.blueColorSlider.value))
        self.SFNode.textField.text = UIColor.hexValue(r: CGFloat(self.SFNode.redColorSlider.value), g: CGFloat(self.SFNode.greenColorSlider.value), b: CGFloat(self.SFNode.blueColorSlider.value))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let text = textField.text {
            self.SFNode.colorNode.backgroundColor = UIColor(hex: text)
        }
        
        textField.resignFirstResponder()
        return true
    }
    
}












