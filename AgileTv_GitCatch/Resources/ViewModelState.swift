//
//  ViewModelState.swift
//  AgileTv_GitCatch
//
//  Created by Luciano Uchoa on 05/02/25.
//


enum ViewModelState<T> {
    case idle
    case loading
    case success(T)
    case error(String)
}

