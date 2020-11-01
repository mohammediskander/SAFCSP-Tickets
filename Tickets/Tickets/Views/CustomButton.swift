//
//  CustomButton.swift
//  CustomButtom
//
//  Created by Abdullah Alhomaidhi on 01/11/2020.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    // MARK: - Inspectable
    
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var buttonBackgroundColor: UIColor = .clear {
        didSet {
            backgroundColor = buttonBackgroundColor
        }
    }
    
    @IBInspectable
    var activityIndicatorColor: UIColor = .white {
        didSet {
            activityIndicator.color = activityIndicatorColor
        }
    }
    
    // MARK: - View
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    // MARK: - Vars
    
    private var originalButtonFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    private var firstTimeLoading = true
    private var originalConstraints = [NSLayoutConstraint]()
    private var originalText = ""

    
   
    
    // MARK: - Setup View
    
    private func setUpView() {
        addSubview(activityIndicator)
    }
    
    // MARK: - Animation
    
    /// This method will start the loading state and make is circular
    func startLoading() {
        
        if firstTimeLoading {
            originalButtonFrame = frame
            originalConstraints = constraints
            originalText = titleLabel?.text ?? ""
            firstTimeLoading = false
        }
        
        NSLayoutConstraint.deactivate(constraints)
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: frame.height),
            widthAnchor.constraint(equalToConstant: frame.height),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        } completion: { (finished) in
            self.activityIndicator.startAnimating()
            self.setTitle(nil, for: .normal)
        }
    }
    
    /// This method will stop the button from loading to its normal state
    func stopLoading() {
        NSLayoutConstraint.deactivate(self.constraints)

        NSLayoutConstraint.activate(self.originalConstraints)
        
        self.activityIndicator.stopAnimating()
        self.setTitle(self.originalText, for: .normal)
        
        UIView.animate(withDuration: 0.5) {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    /// This method will stop loading and shake the  view for a total of 0.3 seconds
    ///
    ///
    /// - Parameter errorBorderColor: is an optional paramter that has a default value of system color red
    
    func showError(errorBorderColor: UIColor = .red) {

        UIView.animate(withDuration: 0.5) {
            self.stopLoading()
        }
        
        
        UIView.animateKeyframes(withDuration: 0.3, delay: 0.5, options: [], animations: {
            self.layer.borderColor = errorBorderColor.cgColor

            CustomButton.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: {
                self.frame = CGRect(x: self.originalButtonFrame.minX-15, y: self.originalButtonFrame.minY, width: self.originalButtonFrame.width, height: self.originalButtonFrame.height)
            })
            
            CustomButton.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
                self.frame = CGRect(x: self.originalButtonFrame.minX+15, y: self.originalButtonFrame.minY, width: self.originalButtonFrame.width, height: self.originalButtonFrame.height)
            })
            
            CustomButton.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25, animations: {
                self.frame = CGRect(x: self.originalButtonFrame.minX-15, y: self.originalButtonFrame.minY, width: self.originalButtonFrame.width, height: self.originalButtonFrame.height)
            })
            
            CustomButton.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25, animations: {
                self.frame = self.originalButtonFrame
            })
        },completion:  {_ in
            self.layer.borderColor = self.borderColor.cgColor
        })
    }
}
