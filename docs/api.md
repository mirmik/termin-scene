# API Reference

Этот раздел фиксирует публичный surface библиотеки.

## Точка входа

- `include/termin_scene/termin_scene.h`
- Сейчас экспортирует: `termin_scene_version_int()`

## Core API

- `include/core/tc_scene.h` — сцена, lifecycle, итерации компонентов, metadata.
- `include/core/tc_scene_pool.h` — pool сцен и scene handles.
- `include/core/tc_entity_pool.h` — сущности, transform, hierarchy, components, SoA API.
- `include/core/tc_entity_pool_registry.h` — registry pool handles.
- `include/core/tc_component.h` — базовая структура компонента, vtable, component registry.
- `include/core/tc_archetype.h` — SoA type registry, archetype storage, query.
- `include/core/tc_scene_extension.h` — scene extensions.

## Utility API

- `include/tc_type_registry.h` — type registry и instance tracking.
- `include/tc_hash_map.h` — `str/u32/u64` hash maps.

## Как читать API

Для каждой функции в документации модулей проверяйте:
- preconditions (какие handle/id должны быть валидны);
- ownership (кто владеет объектом до и после вызова);
- side effects (какие внутренние списки/реестры обновляются);
- fail-soft поведение на невалидных входах.
