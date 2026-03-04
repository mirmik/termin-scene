# Архитектура

## Общая схема

Архитектура разделена на четыре слоя:

1. `Scene` слой (`tc_scene`): контейнер сущностей и lifecycle-цикл.
2. `Entity` слой (`tc_entity_pool`): хранение сущностей, иерархия, transform, флаги.
3. `Component` слой (`tc_component` + `tc_type_registry`): типы компонентов, фабрики, lifecycle-хуки.
4. `SoA` слой (`tc_archetype`): плотные данные и chunk-итерация по маскам типов.

Отдельно стоит слой `tc_scene_extension`: расширения сцены с attach/detach/update/serialize API.

## Ответственность модулей

- `src/tc_scene.c`  
  Управляет scene pool, списками lifecycle-компонентов и update-проходами сцены.
- `src/tc_entity_pool.c`  
  Хранит сущности (SoA/AoS поля), связи parent/child, component arrays, UUID/pick lookup, SoA-маски.
- `src/tc_component.c`  
  Реестр компонентных типов, фабрики, type flags, привязка экземпляров к type entry.
- `src/tc_type_registry.c`  
  Унифицированный type registry: регистрация, версионирование, иерархия типов, tracking инстансов.
- `src/tc_archetype.c`  
  Регистрация SoA-типов, создание архетипов, миграции строк между архетипами, query chunks.
- `src/tc_scene_extension.c`  
  Registry типов расширений и экземпляров расширений на сценах.

## Модель данных

- Сцена владеет `tc_entity_pool`.
- Сущность хранит базовое состояние и список object-компонентов (`tc_component*`).
- SoA-часть сущности задается `type_mask`; данные лежат в соответствующем архетипе.
- Безопасность ссылок обеспечивается generational id/handle моделью.

## Поток кадра

`tc_scene_update(scene, dt)` выполняет:
1. `pending_start` для новых компонентов.
2. `fixed_update` в цикле по accumulator и `fixed_timestep`.
3. `update` для обычного кадра.
4. `on_scene_update` для scene extensions.

`tc_scene_before_render(scene)` выполняет:
1. `before_render` у компонентов.
2. `on_scene_before_render` у scene extensions.

## Границы API

- Публичный surface распределен по заголовкам из `include/core/` и `include/`.
- Большинство функций работают в fail-soft режиме: на невалидном handle/id возвращают `NULL/0/INVALID` или делают no-op.
- Контракты владения компонентами основаны на `retain/release` через `ref_vtable`.
