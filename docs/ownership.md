# Владение и память

## Компоненты

Контракт по `tc_component*`:

- `add_component` делает `retain`, если `factory_retained == false`.
- `remove_component` делает `release`.
- `entity_pool_free` снимает все компоненты и делает `release` для каждого.

Это означает, что хранение внешних сырых указателей на компонент требует аккуратной синхронизации с ref-count моделью.

## Scene ownership

- Сцена владеет своим `tc_entity_pool`.
- При `tc_scene_free` пул удаляется через registry (если зарегистрирован), чтобы инвалидировать handle.

## SoA

- При переходах между архетипами данные копируются для общих типов.
- `free_row` вызывает `destroy`.
- `detach_row` не вызывает `destroy` (используется при миграции между архетипами).

## Extension ownership

- `tc_scene_ext_attach` вызывает `create`.
- `detach`/`detach_all`/`registry_shutdown` вызывает `destroy`.
