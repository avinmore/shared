//
//  FPSTest.swift
//  UITest
//
//  Created by Avin on 24/9/23.
//

import Foundation
import UIKit
class SHPFPSLabel: UILabel {
    enum gestureType {
        case tap;
        case longPress;
    }
    
    typealias onGestureBlock = (_ type: gestureType) -> ()
    var onGesture: onGestureBlock?
    
    lazy var link = CADisplayLink(target: self, selector: #selector(tick(link:)))
    var lastTime: NSInteger = 0
    var count = 0
    
    init() {
        super.init(frame: CGRect(x: 10, y: 100, width: 65, height: 22))
        layer.cornerRadius = 5
        clipsToBounds = true
        textAlignment = .center
        isUserInteractionEnabled = true
        backgroundColor = UIColor(white: 0.0, alpha: 0.7)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap(gestureRecognizer: ))))
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(onLongPress(gestureRecognizer: ))))
//        NotificationCenter.default.addObserver(forName: .SHPLayoutThreadChanged, object: nil, queue: OperationQueue.main) { noti in
//            if let userInfo = noti.userInfo as? [String: Any],
//                let thread = userInfo["thread"] as? Int {
//                if thread == 2 {
//                    self.backgroundColor = UIColor(white: 0.0, alpha: 0.7)
//                } else {
//                    // mainthread
//                    self.backgroundColor = UIColor(red: 36/255.0, green: 113/255.0, blue: 163/255.0, alpha: 0.7)
//                }
//            }
//        }
        link.add(to: .main, forMode: .common)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onTap(gestureRecognizer: UITapGestureRecognizer) {
        self.onGesture?(.tap)
    }
    
    @objc func onLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.ended {
            self.onGesture?(.longPress)
        }
    }
    
    @objc func tick(link: CADisplayLink) {
        if lastTime == 0 {
            lastTime = Int(link.timestamp)
            return
        }
        
        count += 1
        let delta = (Int)(link.timestamp) - lastTime
        if delta < 1 { return }
        lastTime = NSInteger(link.timestamp)
        let fps = count / delta
        count = 0
        
        let progress = fps / 60
        let color = UIColor(hue: 0.27 * (CGFloat(progress) - 0.2), saturation: 1, brightness: 0.9, alpha: 1)
        
        let text = NSMutableAttributedString.init(string: "\(Int(round(Double(fps)))) FPS")
        text.setAttributes([NSAttributedString.Key.foregroundColor : color], range: NSMakeRange(0, text.length - 3))
        text.setAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], range: NSMakeRange(text.length - 3, 3))
        self.attributedText = text
    }
    
    deinit {
        link.invalidate()
    }
}

//private lazy var fpsLabel: SHPFPSLabel = { return SHPFPSLabel() }()

/**
 
 #if DEBUG || INTRELEASE
     private func addFPSLabel() {
         self.view.addSubview(self.fpsLabel)
         self.fpsLabel.onGesture = { [weak self] type in
             guard let self = self else { return }
             switch type {
             case SHPFPSLabel.gestureType.tap:
                 SHPUIProgressHUD.show(SHPHomePageViewController.tagName, in: self.view)
                 
             case SHPFPSLabel.gestureType.longPress:
 #if DEBUG
                 self.triggerHotReload()
 #endif
             }
         }
         
         NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "TEMPLATE_VERSION"), object: nil, queue: .main) { noti in
             if let notiObj = noti.object as? [String: Any],
                let tag = notiObj["tag_version"] as? String{
                 SHPHomePageViewController.tagName = tag
             }
         }
     }
 #endif
 
 */




struct LineHeightMultiple: ViewModifier {
    var multiple: CGFloat

    func body(content: Content) -> some View {
        content
            .overlay(GeometryReader { geometry in
                Color.clear
                    .preference(key: TextHeightPreferenceKey.self, value: geometry.size.height)
            })
            .onPreferenceChange(TextHeightPreferenceKey.self) { height in
                content.lineSpacing(height * (multiple - 1))
            }
    }
}

struct TextHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    func lineHeightMultiple(_ multiple: CGFloat) -> some View {
        self.modifier(LineHeightMultiple(multiple: multiple))
    }
}
