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
        setupUI()
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
