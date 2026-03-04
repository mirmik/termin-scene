# termin-scene

`termin-scene` — scene-core библиотека для движка Termin.

Основная модель:
- сцена (`tc_scene`) хранит сущности и управляет update-циклом;
- сущности живут в `tc_entity_pool`;
- поведение задается компонентами (`tc_component`);
- данные для плотных проходов можно хранить в SoA-архетипах (`tc_archetype`).

Документация описывает фактические контракты текущей реализации: lifecycle, валидность handle, владение памятью и ограничения API.

## Рекомендуемый маршрут

1. [Быстрый старт](getting-started.md)
2. [Философия и контекст](philosophy.md)
3. [Архитектура](architecture.md)
4. [Lifecycle](lifecycle.md)
5. [Handles и валидность](handles.md)
6. [Владение и память](ownership.md)
