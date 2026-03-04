# Быстрый старт

## 1. Создать сцену

```c
tc_scene_handle scene = tc_scene_new_named("Main");
tc_entity_pool* pool = tc_scene_entity_pool(scene);
```

## 2. Создать сущность

```c
tc_entity_id e = tc_entity_pool_alloc(pool, "Player");
```

## 3. Добавить компонент

```c
// c должен быть корректно инициализирован и иметь ref_vtable при необходимости.
tc_entity_pool_add_component(pool, e, c);
```

## 4. Апдейт кадра

```c
tc_scene_update(scene, dt);
tc_scene_before_render(scene);
```

## 5. Освобождение

```c
tc_scene_free(scene);
```

## Важно

- Все handle/id generational: старые значения становятся невалидными после `free`.
- `tc_scene_update` вызывает `start`, `fixed_update`, `update` по внутренним спискам.
- `tc_entity_pool_add_component` может делать `retain`; `remove/free` делает `release`.
