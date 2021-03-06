//: [Previous](@previous)

import Foundation
import UIKit

/*
protocol Key {
    var int:Int? { get }
    init(_ k:Any)
}
extension Key {
    var int:Int? {
        return Int(self)
    }
}

protocol Values {
    func value<T:Key, D>(_ key:D) -> T?
}
extension Values {
    func value<T:Key, D>(_ key:D) -> T? {
        if let arr = self as? Array<Any>,
            let i = key as? Int,
            let v = arr[i] as? AnyHashable {
            return T(v)
        }
        if let dic = self as? Dictionary<AnyHashable, Any>,
            let k = key as? AnyHashable,
            let v = dic[k] as? AnyHashable {
            return T(v)
        }
        return nil
    }
}
extension Int:Key {
    init(_ k: Any) {
        self = k as! Int
    }
}
extension Array:Key {
    init(_ k: Any) {
        self = k as! Array
    }
}
extension Array:Values {
    
}
*/


public protocol Value {
    var int:Int? { get }
    var intValue:Int { get }
    func int<T>(_ key:T) -> Int?
    func intValue<T>(_ key:T) -> Int
    
    var uint:UInt? { get }
    var uintValue:UInt { get }
    func uint<T>(_ key:T) -> UInt?
    func uintValue<T>(_ key:T) -> UInt
    /// 非法-取绝对值
    var uintAbsValue:UInt { get }
    /// 非法-取绝对值
    func uintAbsValue<T>(_ key:T) -> UInt
    
    var float:Float? { get }
    var floatValue:Float { get }
    func float<T>(_ key:T) -> Float?
    func floatValue<T>(_ key:T) -> Float
    
    var double:Double? { get }
    var doubleValue:Double { get }
    func double<T>(_ key:T) -> Double?
    func doubleValue<T>(_ key:T) -> Double
    
    var boolValue:Bool { get }
    func boolValue<T>(_ key:T) -> Bool
    
    var stringValue:String { get }
    func string<T>(_ key:T) -> String?
    func stringValue<T>(_ key:T) -> String
    
    var url:URL? { get }
    var urlValue:URL { get }
    func url<T>(_ key:T) -> URL?
    func urlValue<T>(_ key:T) -> URL
    
    var array:Array<Any>? { get }
    var arrayValue:Array<Any> { get }
    func array<T>(_ key:T) -> Array<Any>?
    func arrayValue<T>(_ key:T) -> Array<Any>
    
    var dict:Dictionary<AnyHashable, Any>? { get }
    var dictValue:Dictionary<AnyHashable, Any> { get }
    func dict<T>(_ key:T) -> Dictionary<AnyHashable, Any>?
    func dictValue<T>(_ key:T) -> Dictionary<AnyHashable, Any>
    
    /*
     var int8:Int8? { get }
     var int8Value:Int8 { get }
     func int8<T>(_ key:T) -> Int8?
     func int8Value<T>(_ key:T) -> Int8
     
     var int16:Int16? { get }
     var int16Value:Int16 { get }
     func int16<T>(_ key:T) -> Int16?
     func int16Value<T>(_ key:T) -> Int16
     
     var int32:Int32? { get }
     var int32Value:Int32 { get }
     func int32<T>(_ key:T) -> Int32?
     func int32Value<T>(_ key:T) -> Int32
     
     var int64:Int64? { get }
     var int64Value:Int64 { get }
     func int64<T>(_ key:T) -> Int64?
     func int64Value<T>(_ key:T) -> Int64
     */
    
    /*
     var uint8:UInt8? { get }
     var uint8Value:UInt8 { get }
     func uint8<T>(_ key:T) -> UInt8?
     func uint8Value<T>(_ key:T) -> UInt8
     
     var uint16:UInt16? { get }
     var uint16Value:UInt16 { get }
     func uint16<T>(_ key:T) -> UInt16?
     func uint16Value<T>(_ key:T) -> UInt16
     
     var uint32:UInt32? { get }
     var uint32Value:UInt32 { get }
     func uint32<T>(_ key:T) -> UInt32?
     func uint32Value<T>(_ key:T) -> UInt32
     
     var uint64:UInt64? { get }
     var uint64Value:UInt64 { get }
     func uint64<T>(_ key:T) -> UInt64?
     func uint64Value<T>(_ key:T) -> UInt64
     */
    
    /*
     var float32:Float32? { get }
     var float32Value:Float32 { get }
     func float32<T>(_ key:T) -> Float32?
     func float32Value<T>(_ key:T) -> Float32
     
     var float64:Float64? { get }
     var float64Value:Float64 { get }
     func float64<T>(_ key:T) -> Float64?
     func float64Value<T>(_ key:T) -> Float64
     
     var float80:Float80? { get }
     var float80Value:Float80 { get }
     func float80<T>(_ key:T) -> Float80?
     func float80Value<T>(_ key:T) -> Float80
     */
}


public extension Value {
    private func isArray<T>(_ key:T) -> Any? {
        guard let arr = self as? Array<Any> else {
            return nil
        }
        guard let i = key as? Int else {
            assertionFailure("👉👉👉\(self)[\(key)] - 数组下标非法 👻")
            return nil
        }
        guard arr.count > i else {
            assertionFailure("👉👉👉\(self)[\(key)] - 数组Index越界 👻")
            return nil
        }
        return arr[i]
    }
    private func isArrayHashable<T>(_ key:T) -> AnyHashable? {
        guard let value = self.isArray(key) as? AnyHashable else {
            return nil
        }
        return value
    }
    private func isDictionary<T>(_ key:T) -> Any? {
        guard let dic = self as? Dictionary<AnyHashable, Any> else {
            return nil
        }
        guard let k = key as? AnyHashable else {
            assertionFailure("👉👉👉\(self)[\(key)] - 字典Key非法 👻")
            return nil
        }
        return dic[k]
    }
    
    private func isDictionaryHashable<T>(_ key:T) -> AnyHashable? {
        guard let value = self.isDictionary(key) as? AnyHashable else {
            return nil
        }
        return value
    }
    
    private func isStringArray<T>(_ key:T) -> Array<String>? {
        /// 字符串分割数组
        if let str = self as? String, let k = key as? String {
            return str.components(separatedBy: k)
        }
        return nil
    }
    
    private func isStringDict<T>(_ key:T) -> Dictionary<AnyHashable,Any>? {
        /// 字符串解析->字典
        return nil
    }
    
    var int: Int? {
        switch self {
        case let i as Int:
            return i
        case let i as Float:
            return Int(i)
        case let i as Double:
            return Int(i)
        case let i as Bool:
            return i ? 1 : 0
        case let i as String:
            return Int(i)
        default:
            return nil
        }
    }
    
    var intValue: Int {
        return self.int ?? 0
    }
    
    func int<T>(_ key:T) -> Int? {
        if let values = self.isArrayHashable(key) {
            return values.int
        }
        if let values = self.isDictionaryHashable(key) {
            return values.int
        }
        return nil
    }
    func intValue<T>(_ key:T) -> Int {
        return self.int(key) ?? 0
    }
    
    var uint: UInt? {
        if let i = self.int, i >= 0 {
            return UInt(i)
        }
        return nil
    }
    var uintValue: UInt {
        return self.uint ?? 0
    }
    
    func uint<T>(_ key:T) -> UInt? {
        if let values = self.isArrayHashable(key) {
            return values.uint
        }
        if let values = self.isDictionaryHashable(key) {
            return values.uint
        }
        return self.uint
    }
    func uintValue<T>(_ key:T) -> UInt {
        return self.uint(key) ?? 0
    }
    /// 非法-取绝对值
    var uintAbsValue:UInt {
        return UInt(abs(self.intValue))
    }
    /// 非法-取绝对值
    func uintAbsValue<T>(_ key:T) -> UInt {
        return UInt(abs(self.intValue(key)))
    }
    
    var float: Float? {
        switch self {
        case let i as Int:
            return Float(i)
        case let i as Float:
            return i
        case let i as Double:
            return Float(i)
        case let i as Bool:
            return i ? 1 : 0
        case let i as String:
            return Float(i)
        default:
            return nil
        }
    }
    var floatValue: Float {
        return self.float ?? 0
    }
    
    func float<T>(_ key:T) -> Float? {
        if let values = self.isArrayHashable(key) {
            return values.float
        }
        if let values = self.isDictionaryHashable(key) {
            return values.float
        }
        return nil
    }
    func floatValue<T>(_ key:T) -> Float {
        return self.float(key) ?? 0
    }
    
    var double: Double? {
        switch self {
        case let i as Int:
            return Double(i)
        case let i as Float:
            return Double(i)
        case let i as Double:
            return Double(i)
        case let i as Bool:
            return i ? 1 : 0
        case let i as String:
            return Double(i)
        default:
            return nil
        }
    }
    var doubleValue: Double {
        return self.double ?? 0
    }
    
    func double<T>(_ key:T) -> Double? {
        if let values = self.isArrayHashable(key) {
            return values.double
        }
        if let values = self.isDictionaryHashable(key) {
            return values.double
        }
        return nil
    }
    func doubleValue<T>(_ key:T) -> Double {
        return self.double(key) ?? 0
    }
    
    var boolValue:Bool {
        switch self {
        case let i as Bool:
            return i
        case let i as Int:
            return i == 1
        case let i as String:
            return ["1","true","yes","y"].contains(i.lowercased())
        default:
            return false
        }
    }
    func boolValue<T>(_ key:T) -> Bool {
        if let values = self.isArrayHashable(key) {
            return values.boolValue
        }
        if let values = self.isDictionaryHashable(key) {
            return values.boolValue
        }
        return false
    }
    
    
    var stringValue:String {
        return "\(self)"
    }
    func string<T>(_ key:T) -> String? {
        if let values = self.isArrayHashable(key) {
            return values.stringValue
        }
        if let values = self.isDictionaryHashable(key) {
            return values.stringValue
        }
        return nil
    }
    func stringValue<T>(_ key:T) -> String {
        return self.string(key) ?? ""
    }
    
    var url:URL? {
        switch self {
        case let i as String:
            return URL(string: i)
        default:
            return nil
        }
    }
    var urlValue:URL {
        return self.url ?? URL(string: "http://")!
    }
    func url<T>(_ key:T) -> URL? {
        if let values = self.isArrayHashable(key) {
            return values.url
        }
        if let values = self.isDictionaryHashable(key) {
            return values.url
        }
        return nil
    }
    func urlValue<T>(_ key:T) -> URL {
        return self.url(key) ?? URL(string: "http://")!
    }
    
    var array:Array<Any>? {
        guard let arr = self as? Array<Any> else {
            return nil
        }
        return arr
    }
    var arrayValue:Array<Any> {
        return self.array ?? []
    }
    
    func array<T>(_ key:T) -> Array<Any>? {
        if let values = self.isArray(key), let value = values as? Array<Any> {
            return value
        }
        if let values = self.isDictionary(key), let value = values as? Array<Any> {
            return value
        }
        if let values = self.isStringArray(key) {
            return values
        }
        return nil
    }
    
    func arrayValue<T>(_ key:T) -> Array<Any> {
        return self.array(key) ?? []
    }
    
    var dict:Dictionary<AnyHashable, Any>? {
        guard let dic = self as? Dictionary<AnyHashable, Any> else {
            return nil
        }
        return dic
    }
    var dictValue:Dictionary<AnyHashable, Any> {
        return self.dict ?? [:]
    }
    func dict<T>(_ key:T) -> Dictionary<AnyHashable, Any>? {
        if let values = self.isArray(key), let value = values as? Dictionary<AnyHashable, Any> {
            return value
        }
        if let values = self.isDictionary(key), let value = values as? Dictionary<AnyHashable, Any> {
            return value
        }
        return nil
    }
    func dictValue<T>(_ key:T) -> Dictionary<AnyHashable, Any> {
        return self.dict(key) ?? [:]
    }
}

extension AnyHashable:Value{}
extension Dictionary:Value {}
extension Array:Value {}
extension String:Value {}
extension Double:Value {}
extension Float:Value {}
extension Int:Value {}
extension Bool:Value {}


let arr:[Any] = [3.0,
                 "3.6",
                 "",
                 -9,
                 [1,"2"],
                 [1:234,
                  "23":[1:2,
                        2:3,
                        3:4]
    ]
]

/*
arr.intValue(1)
arr.uintValue(1)
let uu = arr.uint(3) ?? UInt(abs(arr.intValue(3)))
arr.uintAbsValue(3)
arr.floatValue(1)
arr.urlValue(2)
arr.arrayValue(4)
arr.stringValue(1).arrayValue(".")
arr.dictValue(5).dictValue("23")
*/

//let a = Decimal.init("1.234".doubleValue)
//let b = Decimal(0)


enum CDDecimalRoundingMode {
    /// 四舍五入 fraction: 保留位数
    case tPlain(_ fraction:Int16)
    /// 向下取整
    case tDown(_ fraction:Int16)
    /// 是向上取整
    case tUp(_ fraction:Int16)
    /// 四舍五入的基础上，截断位后值为5时，尾数变成偶数
    case tBankers(_ fraction:Int16)
    
    var modeValue:(NSDecimalNumber.RoundingMode,Int16) {
        switch self {
        case .tPlain(let f):
            return (.plain, f)
        case .tDown(let f):
            return (.down, f)
        case .tUp(let f):
            return (.up, f)
        case .tBankers(let f):
            return (.bankers, f)
        }
        
    }
}

extension String {
    /// 精确取值
    func decimal(_ mode:CDDecimalRoundingMode = .tPlain(2)) -> String {
        //let a = NSDecimalNumber(decimal: Decimal(self.doubleValue))
        //let b = NSDecimalNumber(decimal: Decimal(0))
        let a = NSDecimalNumber(string: self)
        let b = NSDecimalNumber(string: "0")
        let h = NSDecimalNumberHandler(roundingMode: mode.modeValue.0, scale: mode.modeValue.1, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return a.adding(b, withBehavior: h).stringValue
    }
    
    
    func format(){
        
    }
    
    func index(subString s:String) -> Int? {
        guard let r = self.range(of: s) else {
            return nil
        }
        return r.lowerBound.encodedOffset
    }
}

/*
let a = NSDecimalNumber(decimal: Decimal("12345".doubleValue))
let b = NSDecimalNumber(decimal: Decimal(0))
let h = NSDecimalNumberHandler(roundingMode: .bankers, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
a.adding(b, withBehavior: h)
*/
"12399999999999999.005".decimal(.tBankers(2))
"12399999999999999.005".doubleValue

//"123.445".decimal(.tPlain(2))
//"123.524".decimal(.tPlain(2))
//"123.555".decimal(.tPlain(2))


let formatter = NumberFormatter()
formatter.generatesDecimalNumbers = false
formatter.numberStyle = .decimal
formatter.positiveFormat = ".000"
formatter.formatterBehavior
formatter.string(from: 1.235)

String(255, radix: 16)
String(16, radix: 8)
String(16, radix: 2)
String(16, radix: 10)

"1234.56.7".index(subString: ".")
let arrss = "1234.56.7"
print(arrss)
