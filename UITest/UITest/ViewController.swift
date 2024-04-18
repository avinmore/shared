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



/*
import Foundation
import Moya

extension Moya.Response {

    func toCurlString() -> String {
        var curlString = "curl -X \(self.request?.httpMethod ?? "GET") '\(self.request?.url?.absoluteString ?? "")'"

        // Add headers
        if let headers = self.request?.allHTTPHeaderFields {
            for (key, value) in headers {
                curlString += " -H '\(key): \(value)'"
            }
        }

        // Add body data if present
        if let bodyData = self.request?.httpBody, let bodyString = String(data: bodyData, encoding: .utf8) {
            curlString += " -d '\(bodyString)'"
        }

        return curlString
    }
}

// Example usage:
let response = Moya.Response(statusCode: 200, data: Data(), request: URLRequest(url: URL(string: "https://example.com")!), response: nil)

let curlString = response.toCurlString()
print(curlString)

 
 
 struct CurlInfo {
     let request: Moya.Request
     let response: Moya.Response
 }
 
    
 
 import SwiftUI

 struct ContentView: View {
     let curlInfos: [CurlInfo] // Populate this with your CurlInfo objects
     
     var body: some View {
         NavigationView {
             List(curlInfos, id: \.self) { curlInfo in
                 NavigationLink(destination: CurlDetail(curlInfo: curlInfo)) {
                     Text(curlInfo.request.url?.absoluteString ?? "Unknown URL")
                 }
             }
             .navigationTitle("Curl List")
         }
     }
 }
 
 import SwiftUI

 struct CurlDetail: View {
     let curlInfo: CurlInfo
     
     var body: some View {
         VStack {
             Text(curlInfo.response.toCurlString())
                 .padding()
             if let responseData = curlInfo.response.data,
                let responseString = String(data: responseData, encoding: .utf8) {
                 Text(responseString)
                     .padding()
             } else {
                 Text("No response data")
                     .padding()
             }
         }
         .navigationTitle("Curl Detail")
     }
 }
 
 
 
 import SwiftUI

 struct ContentView: View {
     @State private var curlInfos: [CurlInfo] // Use @State for mutable state
     let maxCurlInfosCount = 100
     let userDefaultsKey = "StoredCurlInfos"
     
     init() {
         // Load curlInfos from UserDefaults when the view is initialized
         if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
            let savedCurlInfos = try? JSONDecoder().decode([CurlInfo].self, from: data) {
             _curlInfos = State(initialValue: savedCurlInfos)
         } else {
             _curlInfos = State(initialValue: [])
         }
     }
     
     var body: some View {
         NavigationView {
             List(curlInfos.prefix(maxCurlInfosCount), id: \.self) { curlInfo in
                 NavigationLink(destination: CurlDetail(curlInfo: curlInfo)) {
                     Text(curlInfo.request.url?.absoluteString ?? "Unknown URL")
                 }
             }
             .navigationTitle("Curl List")
         }
         .onDisappear {
             saveCurlInfosToUserDefaults()
         }
     }
     
     private func saveCurlInfosToUserDefaults() {
         if let data = try? JSONEncoder().encode(curlInfos) {
             UserDefaults.standard.set(data, forKey: userDefaultsKey)
         }
     }
 }

*/



/**
 
 private func addNewCurlInfo(_ newCurlInfo: CurlInfo) {
     DispatchQueue.global(qos: .background).async {
         var updatedCurlInfos = self.loadCurlInfosFromUserDefaults()
         updatedCurlInfos.append(newCurlInfo)
         self.saveCurlInfosToUserDefaults(updatedCurlInfos)
     }
 }

 private func loadCurlInfosFromUserDefaults() -> [CurlInfo] {
     guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let savedCurlInfos = try? JSONDecoder().decode([CurlInfo].self, from: data) else {
         return []
     }
     return savedCurlInfos
 }

 private func saveCurlInfosToUserDefaults(_ curlInfos: [CurlInfo]) {
     do {
         let data = try JSONEncoder().encode(curlInfos)
         UserDefaults.standard.set(data, forKey: userDefaultsKey)
     } catch {
         print("Error encoding and saving curlInfos: \(error.localizedDescription)")
     }
 }
 */


////Interview ////

class DataManager: ObservableObject {
    
    
    
    
    func fetch(imageURL: URL, completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global().async {
            let imageData = try! Data(contentsOf: imageURL)
            let image = UIImage(data: imageData)!
            completion(image)
        }
    }
        
    func test() {
        
        let serialQueue = DispatchQueue(label: "com.example.serialQueue")
        serialQueue.sync {
            serialQueue.async {
                debugPrint("LALALALA")
            }
        }
        
        
//        let manager = DataManager()
//        manager.fetch(imageURL: URL(string: "https://fastly.picsum.photos/id/475/200/300.jpg?hmac=YMIlTUXdLfHaFsaEPamJa0Q1D18S9Va6PfM5xyZj9gk")!) { image in
//            debugPrint(image)
//
//        }
    }
}






/*

Question: Explain the difference between nonatomic and atomic properties in Objective-C.

Answer: nonatomic properties are not thread-safe and are faster since they do not use locks. On the other hand, atomic properties are thread-safe but slower due to the overhead of locking mechanisms.   Question: How does autorelease pool work in iOS memory management, and when would you use it?

Answer: Autorelease pool is used to manage memory in iOS applications. Objects added to an autorelease pool are released when the pool is drained, typically at the end of each run loop iteration. It's useful for managing temporary objects or reducing memory footprint in performance-critical code.   Question: Explain the concept of ARC (Automatic Reference Counting) in iOS development.

Answer: ARC is a memory management technique used in Objective-C and Swift. It automatically manages memory by adding and removing object references based on their usage, reducing the need for manual memory management (e.g., calling retain, release, and autorelease).


Question: What is the difference between shallow copy and deep copy in Swift, and when would you use each?

Answer: Shallow copy creates a new object with references to existing objects, while deep copy creates a new object with copies of the original object's properties. Shallow copy is suitable for simple data structures, while deep copy is used for complex objects with nested structures to avoid shared references.


Question: Explain how you would implement data caching in an iOS app to improve performance and offline functionality.

Answer: Data caching involves storing frequently accessed data locally on the device to reduce network requests and provide offline access. Techniques include using NSCache for temporary storage, CoreData for persistent caching, NSURLCache for HTTP caching, and custom caching strategies based on data usage patterns.


  
func fetch(imageURL: URL, completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global().async {
            let imageData = try! Data(contentsOf: imageURL)
            let image = UIImage(data: imageData)!
            completion(image)
        }
    }

Q: what issue you see,  Q: how to fix it Q: how can we make it better / enhance it  Q: can we cache images for better performance ? How?
Q: increase cache size ? how to control app cache size?


 // Accessing 'counter' without synchronization
class DataManager {
    var counter = 0
    func incrementCounter() {
        DispatchQueue.global().async {
            self.counter += 1
        }
    }
}




 // Potential race condition when accessing 'data'
class DataManager {
    var data = [Int]()

    func appendData(value: Int) {
        DispatchQueue.global().async {
            self.data.append(value)
        }
    }
}

solution
class DataManager {
    var data = [Int]()
    let dataQueue = DispatchQueue(label: "com.example.dataQueue", attributes: .concurrent)

    func appendData(value: Int) {
        dataQueue.async(flags: .barrier) {
            self.data.append(value)  // Thread-safe access using a barrier
        }
    }
}



let serialQueue = DispatchQueue(label: "com.example.serialQueue")

serialQueue.sync {
    serialQueue.sync {
        // Nested synchronous dispatch causing deadlock
    }
}
 Solution
let serialQueue = DispatchQueue(label: "com.example.serialQueue")
        serialQueue.sync {
            serialQueue.async {
                debugPrint("LALALALA")
        }
  }

Thread safe singleton

class Singleton {
    private static var instance: Singleton?
    private static let lock = NSLock()

    private init() {}

    static func getInstance() -> Singleton {
        lock.lock()
        defer { lock.unlock() }

        if instance == nil {
            instance = Singleton()
        }
        return instance!
    }
}





import Foundation

struct CacheEntry {
    let key: String
    var value: Any
    var timestamp: Date
}

class ThreadSafeCache {
    private var cache = [String: CacheEntry]()
    private var cacheLock = NSLock()
    private let capacity: Int

    init(capacity: Int) {
        self.capacity = capacity
    }

    func setValue(value: Any, forKey key: String) {
        // Complete the code here
    }

    func getValue(forKey key: String) -> Any? {
        // Complete the code here
    }

    func evictLeastRecentlyUsed() {
        // Complete the code here
    }
}



import Foundation

struct CacheEntry {
    let key: String
    var value: Any
    var timestamp: Date
}

class ThreadSafeCache {
    private var cache = [String: CacheEntry]()
    private var cacheLock = NSLock()
    private let capacity: Int

    init(capacity: Int) {
        self.capacity = capacity
    }

    func setValue(value: Any, forKey key: String) {
        cacheLock.lock()
        defer { cacheLock.unlock() }

        let timestamp = Date()
        let entry = CacheEntry(key: key, value: value, timestamp: timestamp)
        cache[key] = entry

        if cache.count > capacity {
            evictLeastRecentlyUsed()
        }
    }

    func getValue(forKey key: String) -> Any? {
        cacheLock.lock()
        defer { cacheLock.unlock() }

        guard let entry = cache[key] else { return nil }
        entry.timestamp = Date()
        cache[key] = entry
        return entry.value
    }

    func evictLeastRecentlyUsed() {
        guard let lruKey = cache.min(by: { $0.value.timestamp < $1.value.timestamp })?.key else { return }
        cache.removeValue(forKey: lruKey)
    }
}


Thread Safety and Concurrency:

Question: How did you ensure thread safety in the ThreadSafeCache class?

Answer: I ensured thread safety by using an NSLock (cacheLock) to synchronize access to critical sections of code where shared data (cache) is accessed or modified. This prevents multiple threads from concurrently accessing or modifying the cache, avoiding data corruption and race conditions.
Question: What are the potential concurrency issues in a cache implementation, and how did you address them?

Answer: Potential concurrency issues include race conditions when multiple threads access or modify the cache simultaneously, leading to data inconsistency or corruption. I addressed these issues by using the cacheLock to ensure that only one thread can access or modify the cache at a time, maintaining thread safety and data integrity.
Cache Management:

Question: How does the cache manage its capacity, especially when adding new items?

Answer: When adding new items to the cache (setValue method), the cache checks if adding the new item will exceed its capacity. If so, it evicts the least recently used item (evictLeastRecentlyUsed method) to make space for the new item, ensuring that the cache remains within its specified capacity limit.
Question: Explain the logic behind evicting the least recently used item from the cache.

Answer: The logic behind evicting the least recently used (LRU) item is to prioritize keeping recently accessed items in the cache. When the cache capacity is reached and a new item needs to be added, the cache identifies the least recently accessed item based on its timestamp and removes it to make space for the new item. This helps optimize cache performance by retaining frequently accessed items.
Performance Optimization:

Question: Can you suggest any performance optimizations for the ThreadSafeCache class?

Answer: One performance optimization could be implementing a caching strategy such as least frequently used (LFU) or most recently used (MRU) in addition to LRU. This can improve cache hit rates and reduce cache eviction frequency. Additionally, using a concurrent data structure like NSCache or concurrent hash maps can enhance concurrent access performance.
Question: How would you measure and improve the performance of cache operations, especially under high concurrency?

Answer: Performance measurement can be done by tracking metrics such as cache hit rate, eviction rate, and average access time. To improve performance under high concurrency, techniques such as fine-grained locking, lock-free data structures, and caching strategies optimized for specific access patterns can be employed. Load testing with simulated concurrent access can also help identify performance bottlenecks.
Time Complexity:

Question: What is the time complexity of adding and retrieving items from the cache?

Answer: The time complexity of adding and retrieving items from the cache is O(1) on average. This is because accessing or modifying a dictionary (cache) by key has constant time complexity in most cases, assuming a well-distributed hash function.
Question: How does the cache implementation handle time complexity concerns as the number of items grows?

Answer: As the number of items in the cache grows, the time complexity remains O(1) for adding and retrieving items, assuming a properly implemented hash map data structure. However, cache eviction (e.g., LRU eviction) may introduce additional time complexity proportional to the cache capacity and the eviction strategy used.
Concurrency Control Mechanisms:

Question: Why did you choose NSLock as the concurrency control mechanism in this implementation?

Answer: I chose NSLock because it provides a simple and effective way to achieve thread safety by synchronizing access to critical sections of code. While other mechanisms like GCD queues or NSRecursiveLock could also be used, NSLock was suitable for this scenario due to its ease of use and explicit locking mechanism.
Question: What are the advantages and disadvantages of using locks for thread synchronization in a cache?

Answer: The advantages of using locks include simplicity, explicit control over synchronization, and suitability for scenarios where fine-grained control is needed. However, disadvantages may include potential for deadlocks, reduced concurrency in highly contended scenarios, and the need for careful management to avoid performance bottlenecks. Alternative synchronization mechanisms like concurrent data structures or lock-free algorithms may be more suitable for certain use cases.


*/





