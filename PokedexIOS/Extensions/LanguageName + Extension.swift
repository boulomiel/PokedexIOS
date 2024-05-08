//
//  LanguageName + Extension.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 08/05/2024.
//

import Foundation

public extension LanguageName {
    init(_ model: SDLanguageItemName, searchedBy input: String) {
        if model.japHrkt.contains(input) {
            self = .japHrkt(englishName: model.en, name: model.japHrkt)
        } else
        if model.roomaji.contains(input) {
            self = .roomaji(englishName: model.en, name: model.roomaji)
        } else
        if model.ko.contains(input) {
            self = .ko(englishName: model.en, name: model.ko)
        } else
        if model.zhHant.contains(input) {
            self = .zhHant(englishName: model.en, name: model.zhHant)
        } else
        if model.fr.contains(input) {
            self = .fr(englishName: model.en, name: model.fr)
        } else
        if model.de.contains(input) {
            self = .de(englishName: model.en, name: model.de)
        } else
        if model.es.contains(input){
            self = .es(englishName: model.en, name: model.es)
        } else
        if model.it.contains(input) {
            self = .it(englishName: model.en, name: model.it)
        } else
        if model.en.contains(input) {
            self = .en(englishName: model.en)
        } else
        if model.ja.contains(input) {
            self = .ja(englishName: model.en, name: model.ja)
        } else
        if model.zhHans.contains(input) {
            self = .zhHans(englishName: model.en, name: model.zhHans)
        } else {
            self = .en(englishName: model.en)
        }
    }
    
    init(_ model: SDLanguagePokemonName, searchedBy input: String) {
        if model.japHrkt.contains(input) {
            self = .japHrkt(englishName: model.en, name: model.japHrkt)
        } else
        if model.roomaji.contains(input) {
            self = .roomaji(englishName: model.en, name: model.roomaji)
        } else
        if model.ko.contains(input) {
            self = .ko(englishName: model.en, name: model.ko)
        } else
        if model.zhHant.contains(input) {
            self = .zhHant(englishName: model.en, name: model.zhHant)
        } else
        if model.fr.contains(input) {
            self = .fr(englishName: model.en, name: model.fr)
        } else
        if model.de.contains(input) {
            self = .de(englishName: model.en, name: model.de)
        } else
        if model.es.contains(input){
            self = .es(englishName: model.en, name: model.es)
        } else
        if model.it.contains(input) {
            self = .it(englishName: model.en, name: model.it)
        } else
        if model.en.contains(input) {
            self = .en(englishName: model.en)
        } else
        if model.ja.contains(input) {
            self = .ja(englishName: model.en, name: model.ja)
        } else
        if model.zhHans.contains(input) {
            self = .zhHans(englishName: model.en, name: model.zhHans)
        } else {
            self = .en(englishName: model.en)
        }
    }
}

