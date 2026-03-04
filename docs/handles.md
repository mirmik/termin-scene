# Handles и валидность

В ядре используется generational-модель идентификаторов. Это защита от висячих ссылок при удалении и переиспользовании слотов.

## Типы идентификаторов

- `tc_scene_handle` — идентификатор сцены.
- `tc_entity_pool_handle` — идентификатор пула сущностей.
- `tc_entity_id` — идентификатор сущности внутри пула: `{ index, generation }`.
- `tc_entity_handle` — комбинированный handle: `{ pool_handle, entity_id }`.

## Базовый инвариант

После `free/destroy` generation увеличивается. Старые handle/id становятся невалидными даже если тот же `index` позже переиспользован.

## Проверка валидности

- `tc_scene_alive(h)`
- `tc_entity_pool_registry_alive(h)`
- `tc_entity_pool_alive(pool, id)`
- `tc_entity_handle_valid(h)` (через `pool_registry` + `entity_pool_alive`)

## Поведение API на невалидных ссылках

Большинство публичных функций работают в fail-soft режиме:
- возвращают `NULL`, `0` или `INVALID`;
- выполняют no-op для `set/remove/update` операций.

Часть entity-функций дополнительно пишет warning в лог (`WARN_DEAD_ENTITY`).
