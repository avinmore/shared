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
    
    private lazy var progressBar: UIProgressView = {
           let progressView = UIProgressView()
           progressView.progress = 0.5 // 50% progress
           progressView.tintColor = .blue
           progressView.progressTintColor = .blue
           progressView.trackTintColor = .clear
           
           // Remove corner radius from right side
           progressView.layer.cornerRadius = 3
           progressView.clipsToBounds = true
           return progressView
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
        
        self.view.addSubview(progressBar)
                
                progressBar.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview().inset(16)
                    make.center.equalToSuperview().offset(50)
                    make.height.equalTo(6)
                }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeroBadgeView()
        
        setupUI()
    }
    
    
    
    ///TItle info
    
    private lazy var verticalStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 8
            return stackView
        }()
        
        private lazy var roomTitleLabel: UILabel = {
            let label = UILabel()
            label.text = "Room Title"
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            return label
        }()
        
        private lazy var bottomContentView: UIView = {
            let view = UIView()
            view.backgroundColor = .lightGray
            return view
        }()
        
        private lazy var avatarImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "star.fill") // Replace with your avatar image
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        private lazy var labelsStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.distribution = .fillProportionally
            stackView.alignment = .leading
            stackView.axis = .horizontal // Set horizontal axis
            stackView.spacing = 8 // Adjust spacing as needed
            return stackView
        }()
        
        private lazy var seasonNameLabel: UILabel = {
            let label = UILabel()
            label.text = "Season 1"
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 14)
            label.setContentHuggingPriority(.required, for: .horizontal)
            label.setContentCompressionResistancePriority(.required, for: .horizontal)
            return label
        }()
        
        private lazy var episodeLabel: UILabel = {
            let label = UILabel()
            label.text = "Episode 3"
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 14)
            return label
        }()
     
        private func setupUI() {
            self.view.backgroundColor = .white
            
            self.view.addSubview(verticalStackView)
            
            verticalStackView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(16)
            }
            
            verticalStackView.addArrangedSubview(roomTitleLabel)
            
            bottomContentView.addSubview(avatarImageView)
            bottomContentView.addSubview(labelsStackView)
            
            labelsStackView.addArrangedSubview(seasonNameLabel)
            labelsStackView.addArrangedSubview(episodeLabel)
            
            verticalStackView.addArrangedSubview(bottomContentView)
            
            avatarImageView.snp.makeConstraints { make in
                make.width.height.equalTo(16)
                make.leading.centerY.equalToSuperview()
            }
            
            labelsStackView.snp.makeConstraints { make in
                make.leading.equalTo(avatarImageView.snp.trailing).offset(8)
                make.trailing.equalToSuperview()
                make.top.bottom.equalToSuperview().inset(4) // Add top and bottom insets
            }
        }
    ///TItle info
    
}
