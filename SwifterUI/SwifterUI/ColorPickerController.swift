//
//  ColorPickerController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 30/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

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
            let color = UIColor(hex: text)
            self.SFNode.colorNode.backgroundColor = color
            self.SFNode.redColorSlider.slider.setValue(Float(color.getRed()), animated: true)
            self.SFNode.greenColorSlider.slider.setValue(Float(color.getGreen()), animated: true)
            self.SFNode.blueColorSlider.slider.setValue(Float(color.getBlue()), animated: true)
        }
        
        textField.resignFirstResponder()
        return true
    }
    
}












