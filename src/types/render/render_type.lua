---@class RenderState
---@field window_width number                      -- Текущая ширина окна (пиксели)
---@field window_height number                    -- Текущая высота окна (пиксели)
---@field width number                            -- Логическая ширина области рендеринга
---@field height number                           -- Логическая высота области рендеринга
---@field prev_window_width number                -- Предыдущая ширина окна (-1 если не задана)
---@field prev_window_height number               -- Предыдущая высота окна (-1 если не задана)
---@field color vector4                     -- Цвет очистки экрана (RGBA)
---@field clear_buffers table              -- Настройки очистки графических буферов
---@field cameras Cameras                         -- Камеры (GUI и World)
---@field predicates Predicates                   -- Предикаты рендеринга (какие объекты отрисовывать)

---@class Cameras
---@field camera_gui Camera                       -- Камера для GUI-элементов
---@field camera_world url|resource_handle|nil                 -- Камера для игрового мира (может быть nil)

---@class Camera
---@field view matrix4                      -- Матрица вида (view matrix)
---@field near number                             -- Ближняя плоскость отсечения
---@field far number                              -- Дальняя плоскость отсечения
---@field zoom number                             -- Масштаб камеры
---@field frustum any
---@field proj matrix4 | nil
---@field projection_fn fun(camera, state): matrix4 -- Функция проекции
---@field options table                           -- Дополнительные настройки камеры

---@class Predicates
---@field sprite_character render_predicate       -- Предикат для спрайтов персонажей
---@field tile render_predicate                   -- Предикат для тайлов
---@field gui render_predicate                    -- Предикат для GUI-элементов
---@field particle render_predicate               -- Предикат для частиц
---@field model render_predicate                  -- Предикат для 3D-моделей
---@field debug_text render_predicate             -- Предикат для отладочного текста
