import Foundation

struct RotorDataLoader: RotorLoadable {

    var rotorDataSource: [String: AnyObject]?

    init() {
        rotorDataSource = loadDataSource()
    }

    func loadRotorOfType(type: RotorType) -> Rotor? {
        let key = type.rawValue.uppercaseString
        return loadRotorWithKey(key)
    }

    func loadReflectorOfType(type: ReflectorType) -> Rotor? {
        let key = type.rawValue.uppercaseString
        return loadRotorWithKey(key)
    }

    private func loadRotorWithKey(key: String) -> Rotor? {
        guard let dataSource = rotorDataSource else { return nil }
        guard let data = dataSource[key] as? [String: AnyObject] else { return nil }
        return rotorWithData(data)
    }

    private func loadDataSource() -> [String: AnyObject]? {
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource("enigma_rotors", ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        do {
            // swiftlint:disable line_length
            return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String: AnyObject]
        } catch let error {
            print("Error deserialising rotor json data \(error)")
        }
        return nil
    }

    private func rotorWithData(data: [String: AnyObject]) -> Rotor? {
        guard let mapping = data["mapping"] as? [Int] else { return nil }
        let turnover = data["turnover"] as? [Int] ?? []
        return Rotor(mapping: mapping, turnoverNotches: turnover)
    }
}
