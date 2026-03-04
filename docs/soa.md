# SoA и архетипы

SoA-слой хранит data-only компоненты в плотном формате и группирует сущности по `type_mask`.

## Регистрация SoA-типа

```c
tc_soa_type_id id = tc_entity_pool_register_soa_type(pool, &(tc_soa_type_desc){
    .name = "Velocity",
    .element_size = sizeof(Velocity),
    .init = NULL,
    .destroy = NULL
});
```

Ограничение: максимум `64` типа (`TC_SOA_MAX_TYPES`).

## Добавление и удаление

- `tc_entity_pool_add_soa(pool, entity, type_id)`
- `tc_entity_pool_remove_soa(pool, entity, type_id)`

Эти операции меняют `type_mask` сущности и, при необходимости, переносят ее между архетипами.

## Доступ к данным сущности

- `tc_entity_pool_has_soa`
- `tc_entity_pool_get_soa`
- `tc_entity_pool_soa_mask`

## Query по архетипам

`tc_soa_query` фильтрует архетипы по `required_mask` и `excluded_mask` и возвращает chunk:
- `entities`
- `data[]` по required типам
- `count`

## Когда использовать

- SoA подходит для массовых проходов по однотипным данным.
- Object-компоненты остаются удобнее для lifecycle и поведения.
