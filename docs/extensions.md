# Scene Extensions

`tc_scene_extension` позволяет подключать stateful-модули к сцене без изменения core-структур.

## Что дает extension-слой

- Отдельный реестр типов расширений.
- Экземпляры расширений на конкретных сценах.
- Хуки update/before_render.
- Сериализация по `persistence_key`.

## Базовый поток работы

1. Зарегистрировать тип: `tc_scene_ext_register`.
2. Подключить к сцене: `tc_scene_ext_attach(scene, type_id)`.
3. Получить instance при необходимости: `tc_scene_ext_get`.
4. Отключить: `tc_scene_ext_detach` или `tc_scene_ext_detach_all`.

## Хуки расширения

- `on_scene_update(ext, dt, userdata)`
- `on_scene_before_render(ext, userdata)`
- `serialize(ext, out_data, userdata)`
- `deserialize(ext, in_data, userdata)`

Сериализация сцены формирует словарь вида:
`{ "<persistence_key>": <extension_data_dict>, ... }`.
