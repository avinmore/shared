import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var circularView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue // Profile picture background color
        view.layer.cornerRadius = 16 // Half of 16 for circular shape
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.red.cgColor
        return view
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person") // Replace with your image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var initialLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
                
                // Set the frame of the gradient layer to match the view's bounds
                gradientLayer.frame = view.bounds
                
                // Define the colors for the gradient (black to clear)
                let startColor = UIColor.black.cgColor
                let endColor = UIColor.clear.cgColor
                gradientLayer.colors = [startColor, endColor]
                
                // Specify the gradient direction (horizontal)
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                
                // Add the gradient layer to your view's layer
                view.layer.addSublayer(gradientLayer)
                
        
        
        
        //setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(circularView)
        circularView.addSubview(profileImageView)
        circularView.addSubview(initialLabel)
        
        circularView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(32) // Adjust the size as needed
        }
        
        profileImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        initialLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Set the first letter of the name as the label text
        let name = "John"
        if let firstCharacter = name.first {
            initialLabel.text = String(firstCharacter).uppercased()
        }
    }
}
