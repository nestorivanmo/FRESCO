//
//  FCA.swift
//  FRESCO
//
//  Created by Néstor I. Martínez Ostoa on 20/11/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import Foundation

struct FCA {
    static var fg = [
        FoodGroup(name: "Verduras", checked: false, foods:
            [Food(name: "Lechuga", category: .verdura, unit: .tazas, eq: 3.0),
            Food(name: "Jitomate", category: .verdura, unit: .piezas, eq: 2.0),
            Food(name: "Espinaca", category: .verdura, unit: .tazas, eq: 2.0),
            Food(name: "Zanahoria", category: .verdura, unit: .tazas, eq: 0.5),
            Food(name: "Calabacita", category: .verdura, unit: .tazas, eq: 2.0),
            Food(name: "Brócoli", category: .verdura, unit: .tazas, eq: 0.5),
            Food(name: "Nopales", category: .verdura, unit: .tazas, eq: 1.0),
            Food(name: "Sopa de Verduras", category: .verdura, unit: .tazas, eq: 1.0)]
        ),
        FoodGroup(name: "Frutas", checked: false, foods:
            [Food(name: "Manzana, mango manila", category: .fruta, unit: .piezas, eq: 1.0),
            Food(name: "Plátano, pera, mango ataulfo", category: .fruta, unit: .piezas, eq: 0.5),
            Food(name: "Melón, papaya, sandía", category: .fruta, unit: .tazas, eq: 1.0),
            Food(name: "Uvas, cerezas, fresas", category: .fruta, unit: .tazas, eq: 1.0)]
        ),
        FoodGroup(name: "Cerales sin grasa", checked: false, foods:
        
            [Food(name: "Tortilla", category: .cerealSinGrasa, unit: .piezas, eq: 1.0),
            Food(name: "Pasta", category: .cerealSinGrasa, unit: .tazas, eq: 0.5),
            Food(name: "Arroz", category: .cerealSinGrasa, unit: .tazas, eq: 0.25),
            Food(name: "Bolillo", category: .cerealSinGrasa, unit: .piezas, eq: 0.33),
            Food(name: "Pan de Caja", category: .cerealSinGrasa, unit: .piezas, eq: 1),
            Food(name: "Avena", category: .cerealSinGrasa, unit: .tazas, eq: 0.75),
            Food(name: "Hojuelas de maíz (Corn Flakes)", category: .cerealSinGrasa, unit: .tazas, eq: 0.75),
            Food(name: "Cereal de Caja", category: .cerealSinGrasa, unit: .tazas, eq: 0.33),
            Food(name: "Hot Cakes", category: .cerealSinGrasa, unit: .piezas, eq: 0.75)]
        ),
        FoodGroup(name: "Cereales con grasa", checked: false, foods:
            
            [Food(name: "Pan dulce", category: .cerealConGrasa, unit: .piezas, eq: 0.33),
            Food(name: "Barritas", category: .cerealConGrasa, unit: .piezas, eq: 0.75),
            Food(name: "Granola", category: .cerealConGrasa, unit: .tazas, eq: 0.18),
            Food(name: "Galleta tipo sandwich", category: .cerealConGrasa, unit: .piezas, eq: 2.0),
            Food(name: "Palomitas", category: .cerealConGrasa, unit: .piezas, eq: 0.75),
            Food(name: "Papas fritas", category: .cerealConGrasa, unit: .piezas, eq: 0.75),
            Food(name: "Pasteles, pay o panqué", category: .cerealConGrasa, unit: .piezas, eq: 1.0),
            Food(name: "Tamales", category: .cerealConGrasa, unit: .piezas, eq: 0.16),
            Food(name: "Tostada frita o totopos", category: .cerealConGrasa, unit: .piezas, eq: 1.5)]
        ),
        FoodGroup(name: "Grasas con proteína", checked: false, foods:
            [
            Food(name: "Cacahuates", category: .grasasConProteina, unit: .piezas, eq: 14),
            Food(name: "Nueces", category: .grasasConProteina, unit: .piezas, eq: 3),
            Food(name: "Nueces de la India", category: .grasasConProteina, unit: .piezas, eq: 7),
            Food(name: "Almendras", category: .grasasConProteina, unit: .piezas, eq: 10),
            Food(name: "Pistaches", category: .grasasConProteina, unit: .piezas, eq: 18),
            ]
            
        ),
        FoodGroup(name: "Grasas sin proteína", checked: false, foods:
            
            [
                Food(name: "Aceite", category: .grasasSinProteina, unit: .cucharaditas, eq: 1),
                Food(name: "Aguacate", category: .grasasSinProteina, unit: .piezas, eq: 0.33),
                Food(name: "Crema", category: .grasasSinProteina, unit: .cucharadas, eq: 1),
                Food(name: "Mayonesa", category: .grasasSinProteina, unit: .cucharadas, eq: 1),
                Food(name: "Aderezos", category: .grasasSinProteina, unit: .cucharadas, eq: 3),
                Food(name: "Vinagretas", category: .grasasSinProteina, unit: .cucharadas, eq: 0.5),
            
            ]
        
        ),
        FoodGroup(name: "Leguminosas", checked: false, foods:
            
            [
                Food(name: "Frijol, lenteja o garbanzo", category: .leguminosa, unit: .tazas, eq: 0.5),
                Food(name: "Frijoles refritos", category: .leguminosa, unit: .tazas, eq: 0.33),
                Food(name: "Habas, chícharos o garbanzos secos", category: .leguminosa, unit: .tazas, eq: 0.25)
            ]
            
        ),
        FoodGroup(name: "Origen animal", checked: false, foods:
            [
                Food(name: "Pollo", category: .origenAnimal, unit: .pechugas, eq: 0.25),
                Food(name: "Res (bistec)", category: .origenAnimal, unit: .piezas, eq: 30.0),
                Food(name: "Pescado", category: .origenAnimal, unit: .filetes, eq: 30.0),
                Food(name: "Camarones, cangrejo, calamar", category: .origenAnimal, unit: .piezas, eq: 6),
                Food(name: "Huevo", category: .origenAnimal, unit: .piezas, eq: 1.0),
                Food(name: "Jamón", category: .origenAnimal, unit: .rebanadas, eq: 2.0),
                Food(name: "Salchicha", category: .origenAnimal, unit: .piezas, eq: 0.75),
                Food(name: "Queso fresco, blanco, mozarella", category: .origenAnimal, unit: .rebanadas, eq: 1),
                Food(name: "Queso oaxaca, manchego, gouda, parmesano", category: .origenAnimal, unit: .rebanadas, eq: 30)
            ]
        ),
        FoodGroup(name: "Lácteos", checked: false, foods:
        
            [
                Food(name: "Leche/yogurt descremada", category: .lacteo, unit: .tazas, eq: 1),
                Food(name: "Leche/yogurt semidescremada", category: .lacteo, unit: .tazas, eq: 1),
                Food(name: "Leche/yogurt entera", category: .lacteo, unit: .tazas, eq: 1),
                Food(name: "Leche/yogurt con azúcar", category: .lacteo, unit: .tazas, eq: 1)
            ]
        
        ),
        FoodGroup(name: "Azúcares", checked: false, foods:
        
            [
                Food(name: "Azúcar de mesa", category: .azucar, unit: .cucharaditas, eq: 2),
                Food(name: "Mermelada", category: .azucar, unit: .cucharaditas, eq: 2.5),
                Food(name: "Gelatina", category: .azucar, unit: .tazas, eq: 0.25),
                Food(name: "Refresco", category: .azucar, unit: .tazas, eq: 0.25),
                Food(name: "Jugo", category: .azucar, unit: .tazas, eq: 0.5)
            ]
        ),
        FoodGroup(name: "Bebidas alcohólicas", checked: false, foods:
            [
                Food(name: "Cerveza", category: .bebidaAlcoholica, unit: .tazas, eq: 1),
                Food(name: "Ron", category: .bebidaAlcoholica, unit: .tazas, eq: 0.25),
                Food(name: "Vodka", category: .bebidaAlcoholica, unit: .tazas, eq: 0.25),
                Food(name: "Vino tinto", category: .bebidaAlcoholica, unit: .copas, eq: 2),
                Food(name: "Vino blanco", category: .bebidaAlcoholica, unit: .copas, eq: 1)
            ]
            )
        ]
    static let foodGroups = [
        ["Verduras",
        "Frutas",
        "Cerales sin grasa",
        "Cereales con grasa",
        "Grasas con proteína",
        "Grasas sin proteína",
        "Leguminosas",
        "Origen animal",
        "Lácteos",
        "Azúcares",
        "Bebidas alcohólicas"],
        ["Acerca de FCA"]
        ]
    static let sections = [
        "Categorías de alimentos",
        " ",
    ]
    static let foods = [
        [
            Food(name: "Lechuga", category: .verdura, unit: .tazas, eq: 3.0),
            Food(name: "Jitomate", category: .verdura, unit: .piezas, eq: 2.0),
            Food(name: "Espinaca", category: .verdura, unit: .tazas, eq: 2.0),
            Food(name: "Zanahoria", category: .verdura, unit: .tazas, eq: 0.5),
            Food(name: "Calabacita", category: .verdura, unit: .tazas, eq: 2.0),
            Food(name: "Brócoli", category: .verdura, unit: .tazas, eq: 0.5),
            Food(name: "Nopales", category: .verdura, unit: .tazas, eq: 1.0),
            Food(name: "Sopa de Verduras", category: .verdura, unit: .tazas, eq: 1.0)
        ],
        [
            Food(name: "Manzana, mango manila", category: .fruta, unit: .piezas, eq: 1.0),
            Food(name: "Plátano, pera, mango ataulfo", category: .fruta, unit: .piezas, eq: 0.5),
            Food(name: "Melón, papaya, sandía", category: .fruta, unit: .tazas, eq: 1.0),
            Food(name: "Uvas, cerezas, fresas", category: .fruta, unit: .tazas, eq: 1.0),
        ],
        [
            Food(name: "Tortilla", category: .cerealSinGrasa, unit: .piezas, eq: 1.0),
            Food(name: "Pasta", category: .cerealSinGrasa, unit: .tazas, eq: 0.5),
            Food(name: "Arroz", category: .cerealSinGrasa, unit: .tazas, eq: 0.25),
            Food(name: "Bolillo", category: .cerealSinGrasa, unit: .piezas, eq: 0.33),
            Food(name: "Pan de Caja", category: .cerealSinGrasa, unit: .piezas, eq: 1),
            Food(name: "Avena", category: .cerealSinGrasa, unit: .tazas, eq: 0.75),
            Food(name: "Hojuelas de maíz (Corn Flakes)", category: .cerealSinGrasa, unit: .tazas, eq: 0.75),
            Food(name: "Cereal de Caja", category: .cerealSinGrasa, unit: .tazas, eq: 0.33),
            Food(name: "Hot Cakes", category: .cerealSinGrasa, unit: .piezas, eq: 0.75)
        ],
        [
            Food(name: "Pan dulce", category: .cerealConGrasa, unit: .piezas, eq: 0.33),
            Food(name: "Barritas", category: .cerealConGrasa, unit: .piezas, eq: 0.75),
            Food(name: "Granola", category: .cerealConGrasa, unit: .tazas, eq: 0.18),
            Food(name: "Galleta tipo sandwich", category: .cerealConGrasa, unit: .piezas, eq: 2.0),
            Food(name: "Palomitas", category: .cerealConGrasa, unit: .piezas, eq: 0.75),
            Food(name: "Papas fritas", category: .cerealConGrasa, unit: .piezas, eq: 0.75),
            Food(name: "Pasteles, pay o panqué", category: .cerealConGrasa, unit: .piezas, eq: 1.0),
            Food(name: "Tamales", category: .cerealConGrasa, unit: .piezas, eq: 0.16),
            Food(name: "Tostada frita o totopos", category: .cerealConGrasa, unit: .piezas, eq: 1.5)
        ],
        [
            Food(name: "Cacahuates", category: .grasasConProteina, unit: .piezas, eq: 14),
            Food(name: "Nueces", category: .grasasConProteina, unit: .piezas, eq: 3),
            Food(name: "Nueces de la India", category: .grasasConProteina, unit: .piezas, eq: 7),
            Food(name: "Almendras", category: .grasasConProteina, unit: .piezas, eq: 10),
            Food(name: "Pistaches", category: .grasasConProteina, unit: .piezas, eq: 18),
        ],
        [
            Food(name: "Aceite", category: .grasasSinProteina, unit: .cucharaditas, eq: 1),
            Food(name: "Aguacate", category: .grasasSinProteina, unit: .piezas, eq: 0.33),
            Food(name: "Crema", category: .grasasSinProteina, unit: .cucharadas, eq: 1),
            Food(name: "Mayonesa", category: .grasasSinProteina, unit: .cucharadas, eq: 1),
            Food(name: "Aderezos", category: .grasasSinProteina, unit: .cucharadas, eq: 3),
            Food(name: "Vinagretas", category: .grasasSinProteina, unit: .cucharadas, eq: 0.5),
        ],
        [
            Food(name: "Frijol, lenteja o garbanzo", category: .leguminosa, unit: .tazas, eq: 0.5),
            Food(name: "Frijoles refritos", category: .leguminosa, unit: .tazas, eq: 0.33),
            Food(name: "Habas, chícharos o garbanzos secos", category: .leguminosa, unit: .tazas, eq: 0.25),
        ],
        [
            Food(name: "Pollo", category: .origenAnimal, unit: .pechugas, eq: 0.25),
            Food(name: "Res (bistec)", category: .origenAnimal, unit: .piezas, eq: 30.0),
            Food(name: "Pescado", category: .origenAnimal, unit: .filetes, eq: 30.0),
            Food(name: "Camarones, cangrejo, calamar", category: .origenAnimal, unit: .piezas, eq: 6),
            Food(name: "Huevo", category: .origenAnimal, unit: .piezas, eq: 1.0),
            Food(name: "Jamón", category: .origenAnimal, unit: .rebanadas, eq: 2.0),
            Food(name: "Salchicha", category: .origenAnimal, unit: .piezas, eq: 0.75),
            Food(name: "Queso fresco, blanco, mozarella", category: .origenAnimal, unit: .rebanadas, eq: 1),
            Food(name: "Queso oaxaca, manchego, gouda, parmesano", category: .origenAnimal, unit: .rebanadas, eq: 30)
        ],
        [
            Food(name: "Leche/yogurt descremada", category: .lacteo, unit: .tazas, eq: 1),
            Food(name: "Leche/yogurt semidescremada", category: .lacteo, unit: .tazas, eq: 1),
            Food(name: "Leche/yogurt entera", category: .lacteo, unit: .tazas, eq: 1),
            Food(name: "Leche/yogurt con azúcar", category: .lacteo, unit: .tazas, eq: 1)
        ],
        [
            Food(name: "Azúcar de mesa", category: .azucar, unit: .cucharaditas, eq: 2),
            Food(name: "Mermelada", category: .azucar, unit: .cucharaditas, eq: 2.5),
            Food(name: "Gelatina", category: .azucar, unit: .tazas, eq: 0.25),
            Food(name: "Refresco", category: .azucar, unit: .tazas, eq: 0.25),
            Food(name: "Jugo", category: .azucar, unit: .tazas, eq: 0.5),
        ],
        [
            Food(name: "Cerveza", category: .bebidaAlcoholica, unit: .tazas, eq: 1),
            Food(name: "Ron", category: .bebidaAlcoholica, unit: .tazas, eq: 0.25),
            Food(name: "Vodka", category: .bebidaAlcoholica, unit: .tazas, eq: 0.25),
            Food(name: "Vino tinto", category: .bebidaAlcoholica, unit: .copas, eq: 2),
            Food(name: "Vino blanco", category: .bebidaAlcoholica, unit: .copas, eq: 1),
        ]
    ]
        
}
