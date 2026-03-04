# Lifecycle

## Компонент при добавлении

При `tc_entity_pool_add_component`:

1. ставится `owner` (`tc_entity_handle`)
2. при необходимости вызывается `retain`
3. компонент попадает в scene scheduler/list-структуры
4. вызывается `on_added_to_entity`
5. вызывается `on_added`

## Цикл обновления

`tc_scene_update`:

1. `start` для `pending_start` (если `enabled`)
2. `fixed_update` пока `accumulated_time >= fixed_timestep`
3. `update`

Компонент апдейтится только если:
- сам `enabled`
- owner entity либо невалиден, либо `entity.enabled == true`

`tc_scene_editor_update` добавляет фильтр `active_in_editor`.

## Удаление компонента

`tc_entity_pool_remove_component`:

1. `on_removed`
2. unregister из scene
3. `on_removed_from_entity`
4. `owner = INVALID`
5. `release`

## Нотификации сцены

Есть массовые callbacks:
- `on_editor_start`
- `on_scene_inactive` / `on_scene_active`
- `on_render_attach` / `on_render_detach`
