//
//  Error.swift
//  checky
//
//  Created by song on 2022/11/15.
//

import Foundation

enum EventManagerError: LocalizedError {
  case deleteError
  case editError
  case getPermissionError
  case createError
  case EKEventTypeCastingError
  
  var errorDescription: String? {
    switch self {
    case .deleteError:
      return "event μ­μ  μ€ν¨π₯²"
    case .editError:
      return "event μμ  μ€ν¨π₯²"
    case .getPermissionError:
      return "event νμ© μ€ν¨π₯²"
    case .createError:
      return "event μμ± μ€ν¨π₯²"
    case .EKEventTypeCastingError:
      return "event κ΄λ ¨ μ€λ₯κ° λ°μνμμ΅λλ€ κ°λ°μμκ² λ¬Έμ νμ¬ μ£ΌμΈμ π₯²"
    }
  }
}
