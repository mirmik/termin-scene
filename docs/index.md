# termin-scene

`termin-scene` — компактное ядро scene/ECS для движка Termin.

Документация построена по реальной структуре кода:
- `tc_scene`: сцены, lifecycle-циклы, фильтрованные итерации компонентов.
- `tc_entity_pool`: сущности, иерархия, трансформы, флаги, lookup по `uuid`/`pick_id`.
- `tc_component`: object-компоненты с vtable и ref-count контрактом.
- `tc_archetype`: SoA-компоненты и архетипы по `type_mask`.
- `tc_scene_extension`: расширения сцены (attach/detach/update/serialize).

## Что читать сначала

1. [Быстрый старт](getting-started.md)
2. [Философия и контекст](philosophy.md)
3. [Архитектура](architecture.md)
4. [Lifecycle](lifecycle.md)
5. [Handles и валидность](handles.md)
6. [Владение и память](ownership.md)
