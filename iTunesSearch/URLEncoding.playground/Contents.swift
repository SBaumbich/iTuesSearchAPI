
import Foundation

extension String {
    func addingPercentEncoding() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
}

func encodeParametersInURL(_ parameters: [String: Any]) -> String {
    
    var components = [(String, String)]()
    let sortedKeys = parameters.keys.sorted(by: {$0 < $1 })
    
    for key in sortedKeys {
        let value = parameters[key]!
        let queryComponents = queryComponentsWith(key: key, value: value)
        components.append(contentsOf: queryComponents)
    }
    
    let encodedComponents = components.map({"\($0)=\($1)"})
    return encodedComponents.joined(separator: "&")
}


func queryComponentsWith(key: String, value: Any) -> [(String, String)] {
    var components = [(String, String)]()
    
    if let dictionary = value as? [String : Any] {
        for (nestedKey, value) in dictionary {
            let nestedComponents = queryComponentsWith(key: "\(key)[\(nestedKey)]", value: value)
            components.append(contentsOf: nestedComponents)
        }
    } else if let array = value as? [Any] {
        for value in array {
            let nestedComponents = queryComponentsWith(key: "\(key)[]", value: value)
            components.append(contentsOf: nestedComponents)
        }
    } else {
        let encodedKey = key.addingPercentEncoding()
        let encodedValue = "\(value)".addingPercentEncoding()
        let component = (encodedKey, encodedValue)
        components.append(component)
    }
    return components
}


let param = ["foo" : ["bar", 1, true]]
encodeParametersInURL(param)
