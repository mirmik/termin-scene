# Handles и валидность

## Типы идентификаторов

- `tc_scene_handle`: generational handle сцены.
- `tc_entity_pool_handle`: generational handle пула.
- `tc_entity_id`: `{ index, generation }` сущности внутри пула.
- `tc_entity_handle`: `{ pool_handle, entity_id }`.

## Базовое правило

После `free/destroy` generation увеличивается, и старые id/handle считаются протухшими.

## Проверки

- `tc_scene_alive(h)`
- `tc_entity_pool_registry_alive(h)`
- `tc_entity_pool_alive(pool, id)`
- `tc_entity_handle_valid(h)` (через registry + alive check)

## Что делает API при invalid/dead

Большинство функций:
- возвращают `NULL/0/INVALID`
- ничего не делают в `set`/`remove`

Часть entity-путей дополнительно пишет warning в лог (`WARN_DEAD_ENTITY`).
