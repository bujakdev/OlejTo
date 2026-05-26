# 07 Data Model

## Encje domenowe

## Vehicle

- id: String
- make: String
- model: String
- year: int
- licensePlate: String
- currentMileage: int
- oilChangeMileage: int
- oilChangeDate: DateTime
- oilChangeIntervalKm: int
- createdAt: DateTime
- updatedAt: DateTime

## ServiceEntry

- id: String
- vehicleId: String
- date: DateTime
- mileage: int
- serviceType: String
- oilType: String?
- cost: double?
- notes: String?
- createdAt: DateTime

## Reminder

- id: String
- vehicleId: String
- type: String (date|mileage)
- triggerAt: DateTime?
- triggerMileage: int?
- isEnabled: bool

## Relacje

- Vehicle 1..* ServiceEntry
- Vehicle 1..* Reminder

## Reguly biznesowe

- currentMileage nie moze byc mniejsze niz ostatni mileage wpisu.
- oilChangeIntervalKm > 0.
- Dla statusu:
  - OK: pozostalo > 1000 km
  - Wkrotce: 300-1000 km
  - Pilne: < 300 km lub po dacie granicznej

## Migracje danych

- Kazda zmiana modelu zwieksza wersje boxa Hive.
- Dodaj migracje kompatybilna wstecz dla brakujacych pol.
- Test migracji na kopii danych dev.
