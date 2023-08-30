import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var badgeViewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.layer.cornerRadius = 4 // Add corner radius
        stackView.clipsToBounds = true // Clip content to the rounded corners
        return stackView
    }()
    
    private lazy var leftView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var rightView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var playStatusSysmbol: UIView = {
        let view = UIView()
        view.backgroundColor = .white // Set background color
        view.layer.cornerRadius = 3 // Set corner radius to half of width (6px / 2 = 3px)
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var roomStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Example Text"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var personIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill") // Example icon
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var participantsStatuslabel: UILabel = {
        let label = UILabel()
        label.text = "Example Text"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    fileprivate func configureHeroBadgeView() {
        self.view.backgroundColor = .red
        badgeViewStackView.backgroundColor = .green
        
        self.view.addSubview(badgeViewStackView)
        
        badgeViewStackView.snp.makeConstraints { make in
            make.top.leading.equalTo(8.0)
            make.height.equalTo(24)
        }
        
        // Create colored background container for leftView
        let leftViewContainer = UIView()
        leftViewContainer.backgroundColor = .blue // Set background color
        leftViewContainer.addSubview(leftView)
        badgeViewStackView.addArrangedSubview(leftViewContainer)
        
        leftView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)) // Add padding
        }
        
        // Make playStatusSymbol a circular UIView with 6px width and height
        leftView.addSubview(playStatusSysmbol)
        leftView.addSubview(roomStatusLabel)
        
        playStatusSysmbol.snp.makeConstraints { make in
            make.centerY.equalToSuperview() // Vertically center align
            make.leading.equalToSuperview()
            make.width.height.equalTo(6)
        }
        
        roomStatusLabel.snp.makeConstraints { make in
            make.leading.equalTo(playStatusSysmbol.snp.trailing).offset(4)
            make.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        // Create colored background container for rightView
        let rightViewContainer = UIView()
        rightViewContainer.backgroundColor = .black // Set background color
        rightViewContainer.addSubview(rightView)
        badgeViewStackView.addArrangedSubview(rightViewContainer)
        
        rightView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)) // Add padding
        }
        
        rightView.addSubview(personIcon)
        rightView.addSubview(participantsStatuslabel)
        
        personIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.width.equalTo(12)
            make.height.equalToSuperview()
        }
        
        participantsStatuslabel.snp.makeConstraints { make in
            make.leading.equalTo(personIcon.snp.trailing).offset(4)
            make.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeroBadgeView()        
    }
}

