//
//  FloatingTextField.swift
//  LoginScene
//
//  Created by Vikhyath on 05/08/19.
//  Copyright © 2019 Vikhyath. All rights reserved.
//

import UIKit

@IBDesignable open class FloatingTextField: UITextField, UITextFieldDelegate {
    
    public enum AnimationType: Int {
        case textEntry
        case textDisplay
    }
    public typealias AnimationCompletionHandler = (_ type: AnimationType) -> Void
    public let placeholderLabel = UILabel()
    
    private let borderThickness: (active: CGFloat, inactive: CGFloat) = (active: 2, inactive: 0.5)
    private let placeholderInsets = CGPoint(x: 0, y: 10)
    private let textFieldInsets = CGPoint(x: 0, y: 12)
    private var activePlaceholderPoint: CGPoint = CGPoint.zero
    private var animationCompletionHandler: AnimationCompletionHandler?
    
    @IBInspectable dynamic open var placeholderFontSize: CGFloat = 16 {
        didSet {
            updatePlaceholder()
        }
    }
    
    @IBInspectable dynamic open var placeholderScaleDownFontSize: CGFloat = 14
    
    @IBInspectable dynamic open var placeholderColor: UIColor = .black {
        didSet {
            updatePlaceholder()
        }
    }
    
    @IBInspectable dynamic open var placeholderFontScale: CGFloat = 0.65 {
        didSet {
            updatePlaceholder()
        }
    }
    
    @objc open func textFieldDidBeginEditing() {
        animateViewsForTextEntry()
    }
    
    @objc open func textFieldDidEndEditing() {
        animateViewsForTextDisplay()
    }
    
    // MARK: - TextFieldEffects
    
    private func drawViewsForRect(_ rect: CGRect) {
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: rect.size.width, height: rect.size.height))
        
        placeholderLabel.frame = frame.insetBy(dx: placeholderInsets.x, dy: placeholderInsets.y)
        
        updatePlaceholder()
        
        addSubview(placeholderLabel)
    }
    
    private func animateViewsForTextEntry() {
        
        if text!.isEmpty {
            
            UIView.animate(withDuration: 0.5, animations: ({
                self.placeholderLabel.font = UIFont.systemFont(ofSize: self.placeholderScaleDownFontSize)
                self.layoutPlaceholderInTextRect()
                self.placeholderLabel.frame.origin = self.activePlaceholderPoint
            }), completion: { _ in
                self.animationCompletionHandler?(.textEntry)
            })
        }
    }
    
    // MARK: - Private
    
    private func animateViewsForTextDisplay() {
        
        if text!.isEmpty {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.placeholderLabel.font = UIFont.systemFont(ofSize: self.placeholderFontSize)
                self.layoutPlaceholderInTextRect()
            }, completion: { _ in
                self.animationCompletionHandler?(.textDisplay)
            })
        }
    }
    
    private func updatePlaceholder() {
        
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.font = UIFont.systemFont(ofSize: placeholderFontSize)
        placeholderLabel.sizeToFit()
        layoutPlaceholderInTextRect()
        
        if isFirstResponder || text!.isEmpty == false {
            animateViewsForTextEntry()
        }
    }
    
    private func rectForBorder(_ thickness: CGFloat, isFilled: Bool) -> CGRect {
        if isFilled {
            return CGRect(origin: CGPoint(x: 0, y: frame.height-thickness), size: CGSize(width: frame.width, height: thickness))
        } else {
            return CGRect(origin: CGPoint(x: 0, y: frame.height-thickness), size: CGSize(width: 0, height: thickness))
        }
    }
    
    private func layoutPlaceholderInTextRect() {
        
        let textRect = self.textRect(forBounds: bounds)
        var originX = textRect.origin.x
        switch self.textAlignment {
        case .center:
            originX += textRect.size.width/2 - placeholderLabel.bounds.width/2
        case .right:
            originX += textRect.size.width - placeholderLabel.bounds.width
        default:
            break
        }
        
        let yOrigin = text!.isEmpty == true ? textRect.height/2 : -placeholderInsets.y
        let fontName = self.font?.fontName
        self.placeholderLabel.font = UIFont(name: fontName ?? "Helvetica Neue", size: 16)
        
        placeholderLabel.frame = CGRect(x: originX, y: yOrigin,
                                        width: placeholderLabel.bounds.width + 30, height: placeholderLabel.bounds.height)
        activePlaceholderPoint = CGPoint(x: placeholderLabel.frame.origin.x, y: placeholderLabel.frame.origin.y - placeholderLabel.frame.size.height - placeholderInsets.y)
        
    }
    
    // MARK: - Overrides
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewsForTextEntry()
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewsForTextDisplay()
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
    }
    
    override open func drawPlaceholder(in rect: CGRect) {
        // Don't draw any placeholders
    }
    
    override open var text: String? {
        didSet {
            if let text = text, !text.isEmpty || isFirstResponder {
                animateViewsForTextEntry()
            } else {
                animateViewsForTextDisplay()
            }
        }
    }
    
    override open var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    override open var bounds: CGRect {
        didSet {
            //updateBorder()
            updatePlaceholder()
        }
    }
    
    override open func prepareForInterfaceBuilder() {
        drawViewsForRect(frame)
    }
    
    override open func draw(_ rect: CGRect) {
        guard isFirstResponder == false else { return }
        self.delegate = self
        drawViewsForRect(rect)
    }
}
