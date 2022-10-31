//
//  CircleView.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 30/10/2022.
//

import UIKit

class CircleView: UIView {
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var percentContainerView: UIView!    
    @IBOutlet private weak var percentLabel: UILabel!
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)
    var circularViewDuration: TimeInterval = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        Bundle.main.loadNibNamed(R.nib.circleView.name, owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func createCircularPath(percentage: CGFloat) {
        percentLabel.text = String(format: "%0.0f", percentage * 10)
        let endPoint = CGFloat(percentage / 10 * Double.pi)
        // created circularPath for circleLayer and progressLayer
        let center = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: 16,
                                        startAngle: startPoint,
                                        endAngle: endPoint,
                                        clockwise: true)
        // circleLayer path defined to circularPath
        circleLayer.path = circularPath.cgPath
        // ui edits
        circleLayer.fillColor = R.color.primary()?.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 8
        circleLayer.strokeEnd = 1.0
        circleLayer.strokeColor = R.color.primary()?.cgColor
        // added circleLayer to layer
        percentContainerView.layer.addSublayer(circleLayer)
        // progressLayer path defined to circularPath
        progressLayer.path = circularPath.cgPath
        // ui edits
        progressLayer.fillColor = R.color.primary()?.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 4
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = R.color.secondary()?.cgColor
        // added progressLayer to layer
        percentContainerView.layer.addSublayer(progressLayer)
    }
    func progressAnimation(duration: TimeInterval) {
        // created circularProgressAnimation with keyPath
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        // set the end time
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}
