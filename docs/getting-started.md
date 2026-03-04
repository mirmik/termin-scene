# Быстрый старт

Ниже минимальный поток: создать сцену, добавить сущность с компонентом, выполнить update и корректно освободить ресурсы.

## 1. Создать сцену и получить пул сущностей

```c
tc_scene_handle scene = tc_scene_new_named("Main");
tc_entity_pool* pool = tc_scene_entity_pool(scene);
```

## 2. Создать сущность

```c
tc_entity_id e = tc_entity_pool_alloc(pool, "Player");
```

## 3. Создать и добавить компонент

```c
// c должен быть корректно инициализирован
// (vtable, ref_vtable и другие поля по контракту вашего типа компонента).
tc_entity_pool_add_component(pool, e, c);
```

## 4. Выполнить update кадра

```c
tc_scene_update(scene, dt);
tc_scene_before_render(scene);
```

## 5. Освобождение

```c
tc_scene_free(scene);
```

## Что важно помнить

- Все `handle/id` в ядре generational: после `free` старые значения становятся невалидными.
- `tc_scene_update` выполняет `start`, затем `fixed_update`, затем `update`.
- При удалении сцены удаляются ее сущности и освобождаются их компоненты по ref-count контракту (`retain/release`).
