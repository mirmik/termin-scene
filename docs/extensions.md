# Scene Extensions

`tc_scene_extension` дает способ привязать stateful-модули к сцене без изменения core-структур.

## Поток

1. Глобально зарегистрировать тип: `tc_scene_ext_register`.
2. На сцену повесить экземпляр: `tc_scene_ext_attach(scene, type_id)`.
3. Получать экземпляр: `tc_scene_ext_get`.
4. Снимать: `tc_scene_ext_detach` / `tc_scene_ext_detach_all`.

## Хуки

- `on_scene_update(ext, dt, userdata)`
- `on_scene_before_render(ext, userdata)`
- `serialize` / `deserialize`

Сериализация сцены формирует словарь по `persistence_key`.
