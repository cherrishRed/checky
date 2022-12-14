//
//  Error.swift
//  checky
//
//  Created by song on 2022/11/15.
//

import Foundation

enum ReminderManagerError: LocalizedError {
  case deleteError
  case editError
  case getPermissionError
  case createError
  case EKReminderTypeCastingError
  
  var errorDescription: String? {
    switch self {
    case .deleteError:
      return "reminder μ­μ  μ€ν¨π₯²"
    case .editError:
      return "reminder μμ  μ€ν¨π₯²"
    case .getPermissionError:
      return "reminder νμ© μ€ν¨π₯²"
    case .createError:
      return "reminder μμ± μ€ν¨π₯²"
    case .EKReminderTypeCastingError:
      return "reminder κ΄λ ¨ μ€λ₯κ° λ°μνμμ΅λλ€ κ°λ°μμκ² λ¬Έμ νμ¬ μ£ΌμΈμ π₯²"
    }
  }
}
