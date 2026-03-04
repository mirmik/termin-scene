# Ограничения и подводные камни

- `tc_scene_foreach_component_of_type` и type-list логика завязаны на `type_name`.
- Поиск сущности по имени (`tc_scene_find_entity_by_name`) линейный.
- Layer filter в `tc_scene_foreach_drawable` ожидает слой как индекс бита.
- `tc_entity_pool_migrate` переносит компоненты ownership-трансфером, не копированием.
- Родительские связи при pool migration не сохраняются автоматически для корня (дети переносятся рекурсивно).
- SoA-глобальный registry singleton: id стабильны в рамках процесса, но это runtime-реестр.
- API в основном fail-soft: silent return на invalid, поэтому полезно иметь внешние asserts в debug-слое.
