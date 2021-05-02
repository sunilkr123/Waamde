

import Foundation
import UIKit

typealias NullableCompletion = (() -> ())?

enum AlertButton {
    case ok(NullableCompletion), cancel(NullableCompletion), custom(String, NullableCompletion),yes(NullableCompletion),no(NullableCompletion)
    
    var name: String {
        switch self {
        case .ok: return "OK"
        case .cancel: return "Cancel"
        case .custom(let value, _): return value
        case .yes: return "Yes"
        case .no: return "No"
        }
    }
    
    var action: NullableCompletion {
        switch self {
        case .ok(let closure): return closure
        case .cancel(let closure): return closure
        case .custom(_, let closure): return closure
        case .yes(let closure): return closure
        case .no(let closure): return closure
        }
    }
    
    var style: UIAlertAction.Style {
        switch self {
        case .cancel(_): return .cancel
        case .no(_): return .cancel
        default: return .default
        }
    }
}

// MARK: ENUM ALERT TITLE
public enum AlertTitle {
    case appName
    case custom(String)
    
    var value: String {
        switch self {
        case .appName:
            return ""
        case .custom(let name): return name
        }
    }
}

public enum Messages {
    case custom(String)
    var value: String {
        switch self {
        case .custom(let message) : return message
        }
    }
}
