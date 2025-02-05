//
//  json.swift
//  avito-internship
//
//  Created by Антон Тимонин on 14.01.2021.
//

import Foundation

let jsonResponse: String = """
{
    "status": "ok",
    "result": {
        "title": "Сделайте объявление заметнее на 7 дней",
        "actionTitle": "Продолжить без изменений",
        "selectedActionTitle": "Выбрать",
        "list": [
            {
                "id": "xl",
                "title": "XL объявление",
                "description": "Пользователи смогут посмотреть фотографии, описание и телефон прямо из результатов поиска.",
                "icon": {
                    "52x52": "https://www.avito.ru/s/common/components/monetization/icons/apps/vas-xl-52.png"
                },
                "price": "356 ₽",
                "isSelected": true
            },
            {
                "id": "highlight",
                "title": "Выделение",
                "description": "Яркий цвет не даст затеряться среди других объявлений.",
                "icon": {
                  "52x52": "https://www.avito.ru/s/common/components/monetization/icons/apps/vas-highlight-52.png"
                },
                "price": "299 ₽",
                "isSelected": true
            },
            {
                "id": "x10_1",
                "title": "До 10 раз больше просмотров на 1 день",
                "icon": {
                  "52x52": "https://www.avito.ru/s/common/components/monetization/icons/apps/vas-x10_1-52.png"
                },
                "price": "400 ₽",
                "isSelected": false
            },
            {
                "id": "x5_1",
                "title": "До 5 раз больше просмотров на 1 день",
                "icon": {
                  "52x52": "https://www.avito.ru/s/common/components/monetization/icons/apps/vas-x5_1-52.png"
                },
                "price": "230 ₽",
                "isSelected": false
            },
            {
                "id": "x2_1",
                "title": "До 2 раз больше просмотров на 1 день",
                "icon": {
                  "52x52": "https://www.avito.ru/s/common/components/monetization/icons/apps/vas-x2_1-52.png"
            },
                "price": "100 ₽",
                "isSelected": false
            },
            {
                "id": "highlight",
                "title": "Выделение",
                "description": "Яркий цвет не даст затеряться среди других объявлений.",
                "icon": {
                    "52x52": "https://www.avito.ru/s/common/components/monetization/icons/apps/vas-highlight-52.png"
                },
                "price": "299 ₽",
                "isSelected": true
            }
        ]
    }
}
"""

