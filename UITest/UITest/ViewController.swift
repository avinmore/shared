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


/*
 protocol DataStorage {
    func saveData(_ data: Data)
    func loadData() -> Data?
}

class FileManagerDataStorage: DataStorage {
    private let fileName = "data.txt"

    func saveData(_ data: Data) {
        if let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName) {
            do {
                try data.write(to: filePath)
            } catch {
                print("Error saving data: \(error.localizedDescription)")
            }
        }
    }

    func loadData() -> Data? {
        if let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName) {
            do {
                let data = try Data(contentsOf: filePath)
                return data
            } catch {
                print("Error loading data: \(error.localizedDescription)")
            }
        }
        return nil
    }
}
*/


/*
protocol DataStorage {
    func saveData<T: Codable>(_ data: T, to file: String)
    func loadData<T: Codable>(from file: String) -> T?
}

class FileManagerDataStorage: DataStorage {
    private let fileManager = FileManager.default

    func saveData<T: Codable>(_ data: T, to file: String) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            if let filePath = fileURL(for: file) {
                try encodedData.write(to: filePath, options: .atomic)
            }
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }

    func loadData<T: Codable>(from file: String) -> T? {
        if let filePath = fileURL(for: file), fileManager.fileExists(atPath: filePath.path) {
            do {
                let data = try Data(contentsOf: filePath)
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch {
                print("Error loading data: \(error.localizedDescription)")
            }
        }
        return nil
    }

    private func fileURL(for file: String) -> URL? {
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        return documentsDirectory?.appendingPathComponent(file)
    }
}
 
*/
//
//func saveData(_ data: Data) {
//    let queue = DispatchQueue(label: "com.example.dataStorageQueue", attributes: .concurrent)
//    queue.async(flags: .barrier) {
//        if let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName) {
//            do {
//                try data.write(to: filePath, options: .atomic)
//            } catch {
//                print("Error saving data: \(error.localizedDescription)")
//            }
//        }
//    }
//}
