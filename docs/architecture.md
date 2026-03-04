# Архитектура

## Ключевые модули

- `src/tc_scene.c`: глобальный pool сцен, lifecycle списки компонентов.
- `src/tc_entity_pool.c`: хранилище сущностей (SoA/AoS), иерархия, трансформы, миграции.
- `src/tc_component.c`: реестр компонентных типов, фабрики, type flags.
- `src/tc_type_registry.c`: общая type-система с версионированием и tracking инстансов.
- `src/tc_archetype.c`: SoA registry + archetype/query слой.
- `src/tc_scene_extension.c`: расширения сцены.

## Модель данных

- Сцена владеет `tc_entity_pool`.
- Сущности хранят object-компоненты (`tc_component*`) и SoA-маску.
- SoA-компоненты физически лежат в архетипах, сгруппированных по `type_mask`.

## Обновление сцены

`tc_scene_update(dt)`:

1. pending start
2. fixed update в цикле по accumulator/fixed timestep
3. regular update
4. scene extension update hooks

`tc_scene_before_render()`:
- before_render для компонентов
- hooks расширений
