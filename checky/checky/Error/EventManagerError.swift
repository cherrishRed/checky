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
      return "event 삭제 실패🥲"
    case .editError:
      return "event 수정 실패🥲"
    case .getPermissionError:
      return "event 허용 실패🥲"
    case .createError:
      return "event 생성 실패🥲"
    case .EKEventTypeCastingError:
      return "event 관련 오류가 발생하였습니다 개발자에게 문의 하여 주세요 🥲"
    }
  }
}
