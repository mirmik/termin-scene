# Владение и память

Этот раздел фиксирует, кто владеет объектами и кто отвечает за освобождение.

## Владение сценой и сущностями

- Сцена владеет своим `tc_entity_pool`.
- При `tc_scene_free` пул уничтожается, и все сущности сцены удаляются.

## Владение компонентами

Контракт для `tc_component*`:
- `tc_entity_pool_add_component` вызывает `retain`, если `factory_retained == false`.
- `tc_entity_pool_remove_component` вызывает `release`.
- `tc_entity_pool_free(entity)` удаляет все компоненты сущности и вызывает `release` для каждого.

Практическое правило: внешний код не должен рассчитывать на время жизни компонента без учета ref-count контракта.

## Владение SoA-данными

- SoA-данные живут внутри архетипов и принадлежат архетипам.
- При переходе сущности между архетипами общие компоненты копируются.
- `tc_archetype_free_row` вызывает `destroy`.
- `tc_archetype_detach_row` не вызывает `destroy` (используется при миграциях).

## Владение extensions

- `tc_scene_ext_attach` создает instance через `create`.
- `tc_scene_ext_detach`, `tc_scene_ext_detach_all` и shutdown реестра вызывают `destroy`.
