import Foundation
import FirebaseFirestore

struct DBImport {
    static let about: [String: Any] = [
    "al": "KOVID-19 është një sëmundje e shkaktuar nga SARS-CoV-2, një virus i familjes Coronavirus, i zbuluar fillimisht në Kinë në Dhjetor 2019. Virusi është shkaku i sëmundjes akute të frymëmarrjes virale. Transmetimi njeri-tek-njeri është i mundur me anë të prekjes dhe pikimit (teshtitjes, kollitjes, etj.). \n\nPeriudha e inkubacionit të virusit është një maksimum prej 14 ditësh, në të cilat personat e infektuar nuk tregojnë simptoma, por mund ta transmetojnë virusin te njerëzit e tjerë.\n\nTë gjithë pasagjerët që vijnë nga vendet me rrezik të lartë dhe të mesëm duhet të mbahen në izolim. nga 14 ditë në shtëpinë e tyre dhe raportoni tek autoritetet nëse ata shfaqin simptoma.",
    "en": "KOVID-19 is a disease caused by SARS-CoV-2, a virus of the Coronavirus family, originally discovered in China in December 2019. The virus is the cause of acute viral respiratory disease. Human-to-human transmission is possible by touch and by drip (sneezing, coughing, etc.).\n\nThe incubation period of the virus is a maximum of 14 days, in which infected people show no symptoms, but can transmit the virus to other people.\n\nAll travelers coming from high and medium risk countries should stay in self-isolation for 14 days at their home and report to the authorities if they experience symptoms.",
    "mk": "КОВИД-19 е заболување предизвикано од SARS-CoV-2, вирус од фамилијата Коронавирус, првично откриен во Кина во декември 2019 година. Вирусот е причинител на акутно вирусно респираторно заболување. Преносот од човек на човек е можен, преку допир и преку капков пат (кивање, кашлање и слично).\n\nПрвичните искуства покажуваат дека постарите лица и хронично болните се изложени на поголем ризик од компликации и тешки форми на заболувањето. Периодот на инкубација на вирусот е најмногу 14 дена, во кој заразените лица не покажуваат симптоми, но можат да го пренесат вирусот на други лица.\n\nСите патници кои доаѓаат од земјите со висок и среден ризик треба да се задржат во само-изолација од 14 дена во нивниот дом и да пријават на надлежните органи доколку почувствуваат симптоми."
    ]
    
    static let help: [[String: Any]] = [
        ["phone_number": "078 545 444",
         "location": [
            "en" : "PE Gevgelija",
            "mk" : "ПЕ Гевгелија",
            "al" : "PE Gevgelija"]
        ],
        ["phone_number" : "070 215 851",
         "location" : [
            "en" : "CJZ Kumanovo",
            "mk" : "ЦЈЗ Куманово",
            "al" : "CJZ Kumanovo"]
        ],
        ["phone_number" : "071 289 614",
         "location" : [
            "en" : "CJZ Skopje",
            "mk" : "ЦЈЗ Скопје",
            "al" : "CJZ Skopje"]
        ],
        ["phone_number" : "02 15 123",
         "location" : [
            "en" : "ZD Skopje - Alo doktore",
            "mk" : "3Д Скопје - Ало докторе",
            "al" : "ZD Skopje - Alo doktore"]
        ],
        ["phone_number" : "070 723 029",
         "location" : [
            "en" : "CJZ Ohrid",
            "mk" : "ЦЈЗ Охрид",
            "al" : "CJZ Ohrid"]
        ],
        ["phone_number" : "075 240 464",
         "location" : [
            "en" : "CJZ Tetovo",
            "mk" : "ЦЈЗ Тетово",
            "al" : "CJZ Tetovo"]
        ],
        ["phone_number" : "076 365 161",
         "location" : [
            "en" : "PE Gostivar",
            "mk" : "ПЕ Гостивар",
            "al" : "PE Gostivar"]
        ],
        ["phone_number" : "078 365 613",
         "location" : [
            "en" : "CJZ Shtip",
            "mk" : "ЦЈЗ Штип",
            "al" : "CJZ Shtip"]
        ],
        ["phone_number" : "071 261 330",
         "location" : [
            "en" : "CJZ Bitola",
            "mk" : "ЦЈЗ Битола",
            "al" : "CJZ Bitola"]
        ],
        ["phone_number" : "072 235 543",
         "location" : [
            "en" : "CJZ Strumica",
            "mk" : "ЦЈЗ Струмица",
            "al" : "CJZ Strumica"]
        ],
        ["phone_number" : "078 387 194",
         "location" : [
            "en" : "IJZ Skopje",
            "mk" : "ИЈЗ Скопје",
            "al" : "IJZ Skopje"]
        ],
        ["phone_number" : "076 475 747",
         "location" : [
            "en" : "CJZ Prilep",
            "mk" : "ЦЈЗ Прилеп",
            "al" : "CJZ Prilep"]
        ],
        ["phone_number" : "071 373 913",
         "location" : [
            "en" : "CJZ Kochani",
            "mk" : "ЦЈЗ Кочани",
            "al" : "CJZ Kochani"]
        ]
    ]
    
    static let country: [String: Any] = [
        "date": Timestamp(date: Date()),
        "sick" : 60,
        "cured" : 10,
        "death" : 20,
        "active" : 350
    ]
    
    static let citites: [[String: Any]] = [
        ["city": [
            "en": "Prilep",
            "mk": "Прилеп",
            "al": "Prilep"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Probishtip",
            "mk": "Пробиштип",
            "al": "Probishtip"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Makedonska Kamenica",
            "mk": "Македонска Каменица",
            "al": "Makedonska Kamenica"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Skopje",
            "mk": "Скопје",
            "al": "Skopje"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Radovish",
            "mk": "Радовиш",
            "al": "Radovish"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Krushevo",
            "mk": "Крушево",
            "al": "Krushevo"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Vinica",
            "mk": "Виница",
            "al": "Vinica"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Delchevo",
            "mk": "Делчево",
            "al": "Delchevo"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Kavadarci",
            "mk": "Кавадарци",
            "al": "Kavadarci"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Dojran",
            "mk": "Дојран",
            "al": "Dojran"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Shtip",
            "mk": "Штип",
            "al": "Shtip"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Kratovo",
            "mk": "Кратово",
            "al": "Kratovo"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Berovo",
            "mk": "Берово",
            "al": "Berovo"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Ohrid",
            "mk": "Охрид",
            "al": "Ohrid"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Kumanovo",
            "mk": "Куманово",
            "al": "Kumanovo"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Negotino",
            "mk": "Неготино",
            "al": "Negotino"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Kriva Palanka",
            "mk": "Крива Паланка",
            "al": "Kriva Palanka"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Veles",
            "mk": "Велес",
            "al": "Veles"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Sveti Nikole",
            "mk": "Свети Николе",
            "al": "Sveti Nikole"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Strumica",
            "mk": "Струмица",
            "al": "Strumica"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Demir Kapija",
            "mk": "Демир Капија",
            "al": "Demir Kapija"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Debar",
            "mk": "Дебар",
            "al": "Debar"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ],
        ["city": [
            "en": "Gevgelija",
            "mk": "Гевгелија",
            "al": "Gevgelija"
            ],
         "sick": 30,
         "cured": 65,
         "death": 6,
         "active": 77,
        ]
    ]
    
    static let questions: [[String: Any]] = [
        ["title": [
            "en": "How do you fill at this moment?",
            "mk": "Како се чувствувате во моментов?",
            "al": "Si po ndiheni tani?"],
         "description": [
            "en": "Select one of following options.",
            "mk": "Изберете една од понудените опции подолу.",
            "al": "Zgjidhni një nga opsionet e ofruara më poshtë."],
         "answers": [
            ["title": [
                "en": "Normally",
                "mk": "Нормално",
                "al": "Normalisht"],
             "colored": false],
            ["title": [
               "en": "I'm not feeling well",
               "mk": "Не ми е добро",
               "al": "Nuk po ndihem mirë"],
            "colored": false],
            ["title": [
               "en": "Extremely bad",
               "mk": "Исклучително лошо",
               "al": "Ekstremisht i keq"],
            "colored": false]
            ]
        ],
        ["title": [
            "en": "Do you have a persistent cough?",
            "mk": "Дали имате постојана кашлица?",
            "al": "A keni një kollë të vazhdueshme?"],
         "description": [
            "en": "Do you cough often for more than an hour?",
            "mk": "Дали кашлате често во периоди подолги од еден час?",
            "al": "A kolliteni shpesh për më shumë se një orë?"],
         "answers": [
            ["title": [
                "en": "Yes",
                "mk": "Да",
                "al": "Po"],
             "colored": false],
            ["title": [
               "en": "No",
               "mk": "Не",
               "al": "Jo"],
            "colored": false],
            ]
        ],
        ["title": [
            "en": "Do you currently have a fever?",
            "mk": "Дали во моментов имате треска?",
            "al": "A keni aktualisht ethe?" ],
         "description": [
            "en": "Do you have a fever?",
            "mk": "Дали имате покачена телесна температура?",
            "al": "Keni ethe?"],
         "answers": [
            ["title": [
                "en": "Yes",
                "mk": "Да",
                "al": "Po"],
             "colored": false],
            ["title": [
               "en": "No",
               "mk": "Не",
               "al": "Jo"],
            "colored": false],
            ]
        ],
        ["title": [
            "en": "KOVID-19 questionnaire",
            "mk": "КОВИД-19 прашалник",
            "al": "Pyetësori KOVID-19"],
         "description": [
            "en": "Have you done a test for KOVID-19?",
            "mk": "Дали имате направено тестирање за КОВИД-19?",
            "al": "A keni bërë një provë për KOVID-19?"],
         "answers": [
            ["title": [
                "en": "Yes",
                "mk": "Да",
                "al": "Po"],
             "colored": false],
            ["title": [
               "en": "No",
               "mk": "Не",
               "al": "Jo"],
            "colored": false],
            ]
        ]
    ]
    
    static func saveDataToFirestore() {
        let db      = Firestore.firestore()
        let batch   = db.batch()
         
        /* About */
        let aboutRef = db.collection("north_macedonia").document("about")
        batch.setData(about, forDocument: aboutRef)

        /* Country Info */
        let baseInfoRef = db.collection("north_macedonia").document("base_info")
        batch.setData(country, forDocument: baseInfoRef)

        /* Cities Info */
        for city in citites {
            let ref = db.collection("north_macedonia").document("base_info").collection("cities").document(UUID().uuidString)
            batch.setData(city, forDocument: ref)
        }

        /* Help Numbers */
        for number in help {
            let ref = db.collection("north_macedonia").document("help_numbers").collection("locations").document(UUID().uuidString)
            batch.setData(number, forDocument: ref)
        }
        
        /* Help Numbers */
        for quesrtion in questions {
            let ref = db.collection("questions").document(UUID().uuidString)
            batch.setData(quesrtion, forDocument: ref)
        }
        
        batch.commit()
    }
}
