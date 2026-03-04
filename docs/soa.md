# SoA и архетипы

## Регистрация типа

```c
tc_soa_type_id id = tc_entity_pool_register_soa_type(pool, &(tc_soa_type_desc){
    .name = "Velocity",
    .element_size = sizeof(Velocity),
    .init = NULL,
    .destroy = NULL
});
```

Ограничение: максимум `64` SoA-типа (`TC_SOA_MAX_TYPES`).

## Добавление/удаление SoA-компонента

- `tc_entity_pool_add_soa(pool, entity, type_id)`
- `tc_entity_pool_remove_soa(pool, entity, type_id)`

Эти операции меняют `type_mask` сущности и переносят ее между архетипами.

## Доступ к данным

- `tc_entity_pool_has_soa`
- `tc_entity_pool_get_soa`
- `tc_entity_pool_soa_mask`

## Query

`tc_soa_query` фильтрует архетипы по `required_mask` и `excluded_mask`, отдавая chunk:
- `entities`
- `data[]` по required типам
- `count`
