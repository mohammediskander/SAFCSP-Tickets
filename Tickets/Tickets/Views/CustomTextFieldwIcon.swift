//
//  CustomTextFieldwIcon.swift
//  Texts
//
//  Created by Abdullah Alhomaidhi on 31/10/2020.
//

import UIKit

@IBDesignable
class CustomTextFieldwIcon: UIView {
    
    
    static var sizeFactor: Double = 0.95
    var imageSize = CGSize()
    var smallImageSize = CGSize()

    var firstTime = true
    
    // MARK: - Inspectabels

    @IBInspectable var viewBackgroundColor: UIColor = .clear {
        didSet{
            backgroundColor = viewBackgroundColor
        }
    }
    
    @IBInspectable var textFieldPlaceHolder: String = "" {
        didSet{
            textField.placeholder = textFieldPlaceHolder
        }
    }
    
    @IBInspectable var icon: UIImage? = nil {
        didSet{
            imageView.image = icon
        }
    }
    
    @IBInspectable var underLineThickness: Float = 1 {
        didSet{
            underLineView.frame.size.height = CGFloat(underLineThickness)
        }
    }
    
    @IBInspectable var underLineColor: UIColor = .clear {
        didSet{
            underLineView.backgroundColor = underLineColor
        }
    }
    
    
    
    // MARK: - Views
    
    var textField: UITextField =  {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
        
    private var underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    
    // MARK: - Setup views
    
    private func setUpView() {
        
        textField.delegate = self
        
        addSubview(imageView)
        addSubview(textField)
        addSubview(underLineView)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: textField.leadingAnchor, constant: -5),
        ])
        
        
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            underLineView.topAnchor.constraint(equalTo: textField.bottomAnchor,constant: 5),
            underLineView.heightAnchor.constraint(equalToConstant: CGFloat(underLineThickness)),
            underLineView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            underLineView.trailingAnchor.constraint(equalTo: textField.trailingAnchor
            )
        ])
        
        // To keep text field wide
        textField.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        underLineView.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)

        // To compress textfield before label
        textField.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .horizontal)
        imageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 751), for: .horizontal)
        underLineView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 751), for: .vertical)
    }
    
    // MARK: - Animation
    /// This method will shake the  view for a total of 0.3 seconds
    ///
    ///
    /// - Parameter errorBorderColor: is an optional paramter that has a default value of system color red
    
    func showError(errorBorderColor: UIColor = .red) {
        let ogFrame = frame
        self.underLineView.backgroundColor = errorBorderColor

        UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [], animations: {
            
            CustomTextFieldwIcon.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: {
                self.frame = CGRect(x: ogFrame.minX-15, y: ogFrame.minY, width: ogFrame.width, height: ogFrame.height)
            })
            
            CustomTextFieldwIcon.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
                self.frame = CGRect(x: ogFrame.minX+15, y: ogFrame.minY, width: ogFrame.width, height: ogFrame.height)
            })
            
            CustomTextFieldwIcon.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25, animations: {
                self.frame = CGRect(x: ogFrame.minX-15, y: ogFrame.minY, width: ogFrame.width, height: ogFrame.height)
            })
            
            CustomTextFieldwIcon.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25, animations: {
                self.frame = ogFrame
            })
        },completion:  {_ in
            self.underLineView.backgroundColor = self.underLineColor
        })
    
    }
    
}

extension CustomTextFieldwIcon: UITextFieldDelegate {
    
    
    internal func textFieldDidChangeSelection(_ textField: UITextField) {

        if firstTime {
            imageSize = imageView.frame.size
            smallImageSize = CGSize(width: Double(imageSize.width) * CustomTextFieldwIcon.sizeFactor, height: Double(imageSize.height) * CustomTextFieldwIcon.sizeFactor)
            firstTime = false
        }

        if let text = textField.text, text.count >= 1, imageView.frame.size != smallImageSize {
            NSLayoutConstraint.deactivate(self.imageView.constraints)
            UIView.animate(withDuration: 0.3){
                NSLayoutConstraint.activate([
                    self.imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                    self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                    self.imageView.trailingAnchor.constraint(equalTo: self.textField.leadingAnchor, constant: -5),
                    self.imageView.heightAnchor.constraint(equalToConstant: self.smallImageSize.height),
                    self.imageView.widthAnchor.constraint(equalToConstant: self.smallImageSize.width)
                ])
            }
        } else if let text = textField.text, text.count == 0, imageView.frame.size != imageSize {
            NSLayoutConstraint.deactivate(self.imageView.constraints)
            UIView.animate(withDuration: 0.3){
                NSLayoutConstraint.activate([
                    self.imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                    self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                    self.imageView.trailingAnchor.constraint(equalTo: self.textField.leadingAnchor, constant: -5),
                    self.imageView.heightAnchor.constraint(equalToConstant: self.imageSize.height),
                    self.imageView.widthAnchor.constraint(equalToConstant: self.imageSize.width)
                ])            }
        }
        self.imageView.layoutIfNeeded()
    }

    
    
}
