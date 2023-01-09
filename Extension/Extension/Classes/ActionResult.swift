//
//  ActionResult.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Action
import RxSwift


public struct ActionResult<Element> {
  public let elements: Observable<Element>
  public let errors: Observable<ActionError>
  public let enabled: Observable<Bool>
  public let executing: Observable<Bool>
}

public extension Action {
  func toResult() -> ActionResult<Element> {
    return ActionResult(elements: elements, errors: errors, enabled: enabled, executing: executing)
  }
}

public extension ActionResult {
  func doOnNext(_ onNext: @escaping ((Element) throws -> Void)) -> ActionResult<Element> {
    return ActionResult<Element>(elements: elements.do(onNext: onNext), errors: errors, enabled: enabled, executing: executing)
  }

  func doOnError(_ onError: @escaping ((ActionError) throws -> Void)) -> ActionResult<Element> {
    return ActionResult<Element>(elements: elements, errors: errors.do(onNext: onError), enabled: enabled, executing: executing)
  }

  func map<R>(_ transform: @escaping (Element) throws -> R) -> ActionResult<R> {
    let newElements = elements.map(transform)
    return ActionResult<R>(elements: newElements, errors: errors, enabled: enabled, executing: executing)
  }

  func flatMap<R>(_ transform: @escaping (Element) throws -> Observable<R>) -> ActionResult<R> {
    let newElements = elements.flatMap(transform)
    return ActionResult<R>(elements: newElements, errors: errors, enabled: enabled, executing: executing)
  }

  func swapEnabled(_ newEnabled: Observable<Bool>) -> ActionResult<Element> {
    return ActionResult<Element>(elements: elements, errors: errors, enabled: newEnabled, executing: executing)
  }

  func swapExecuting(_ newExecuting: Observable<Bool>) -> ActionResult<Element> {
    return ActionResult<Element>(elements: elements, errors: errors, enabled: enabled, executing: newExecuting)
  }

  func swapErrors(_ newErrors: Observable<ActionError>) -> ActionResult<Element> {
    return ActionResult<Element>(elements: elements, errors: newErrors, enabled: enabled, executing: executing)
  }
}
