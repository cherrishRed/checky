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
      return "reminder 삭제 실패🥲"
    case .editError:
      return "reminder 수정 실패🥲"
    case .getPermissionError:
      return "reminder 허용 실패🥲"
    case .createError:
      return "reminder 생성 실패🥲"
    case .EKReminderTypeCastingError:
      return "reminder 관련 오류가 발생하였습니다 개발자에게 문의 하여 주세요 🥲"
    }
  }
}
