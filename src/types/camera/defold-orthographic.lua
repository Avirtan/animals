---@class CameraSettings
---@field id hash|string Идентификатор камеры
---@field url url URL скрипта камеры
---@field component_url url URL компонента камеры
---@field enabled boolean Включена ли камера
---@field order number Порядок рендеринга камеры
---@field view matrix4 Матрица вида камеры
---@field projection matrix4 Матрица проекции камеры
---@field near_z number Ближняя плоскость отсечения
---@field far_z number Дальняя плоскость отсечения
---@field zoom number Масштаб камеры
---@field automatic_zoom boolean Автоматический масштаб
---@field viewport vector4 Область просмотра (x,y - левый нижний угол, z,w - ширина, высота)
---@field offset vector3 Смещение камеры (для эффектов встряски)
---@field shake? {intensity: number, duration: number, horizontal: boolean, vertical: boolean, offset: vector3, cb: function} Эффект встряски
---@field recoil? {offset: vector3, duration: number, time_left: number} Эффект отдачи

---@class CameraModule
---@field MSG_ENABLE hash Сообщение включения камеры
---@field MSG_DISABLE hash Сообщение выключения камеры
---@field MSG_UNFOLLOW hash Сообщение отмены следования
---@field MSG_FOLLOW hash Сообщение следования за объектом
---@field MSG_FOLLOW_OFFSET hash Сообщение изменения смещения слежения
---@field MSG_RECOIL hash Сообщение эффекта отдачи
---@field MSG_SHAKE hash Сообщение эффекта встряски
---@field MSG_SHAKE_COMPLETED hash Сообщение завершения встряски
---@field MSG_STOP_SHAKING hash Сообщение остановки встряски
---@field MSG_DEADZONE hash Сообщение установки мертвой зоны
---@field MSG_BOUNDS hash Сообщение установки границ
---@field MSG_UPDATE_CAMERA hash Сообщение обновления камеры
---@field MSG_ZOOM_TO hash Сообщение изменения масштаба
---@field MSG_SET_AUTOMATIC_ZOOM hash Сообщение установки авто-масштаба
---@field MSG_VIEWPORT hash Сообщение изменения области просмотра
---@field SHAKE_BOTH hash Тип встряски - по всем осям
---@field SHAKE_HORIZONTAL hash Тип встряски - горизонтальная
---@field SHAKE_VERTICAL hash Тип встряски - вертикальная
---@field PROJECTOR table Настройки проектора (устарело)
local M = {}

---Инициализирует камеру
---@param camera_id hash|string Идентификатор камеры
---@param _ any Не используется (оставлено для обратной совместимости)
---@param settings CameraSettings Настройки камеры
function M.init(camera_id, _, settings) end

---Завершает работу камеры
---@param camera_id hash|string Идентификатор камеры
function M.final(camera_id) end

---Обновляет состояние камеры
---@param camera_id hash|string Идентификатор камеры
---@param dt number Время с последнего обновления
function M.update(camera_id, dt) end

---Возвращает список идентификаторов камер
---@return hash[] Список идентификаторов камер
function M.get_cameras() end

---Заставляет камеру следовать за объектом
---@param camera_id? hash|string Идентификатор камеры (nil для первой камеры)
---@param target hash Целевой объект
---@param options? {lerp: number, offset: vector3, horizontal: boolean, vertical: boolean, immediate: boolean} Опции слежения
function M.follow(camera_id, target, options) end

---Прекращает следование камеры за объектом
---@param camera_id? hash|string Идентификатор камеры (nil для первой камеры)
function M.unfollow(camera_id) end

---Устанавливает смещение при слежении
---@param camera_id? hash|string Идентификатор камеры (nil для первой камеры)
---@param offset vector3 Смещение от цели
function M.follow_offset(camera_id, offset) end

---Устанавливает мертвую зону камеры
---@param camera_id? hash|string Идентификатор камеры (nil для первой камеры)
---@param left? number Левая граница (nil для удаления зоны)
---@param top? number Верхняя граница
---@param right? number Правая граница
---@param bottom? number Нижняя граница
function M.deadzone(camera_id, left, top, right, bottom) end

---Устанавливает границы движения камеры
---@param camera_id? hash|string Идентификатор камеры (nil для первой камеры)
---@param left? number Левая граница (nil для удаления границ)
---@param top? number Верхняя граница
---@param right? number Правая граница
---@param bottom? number Нижняя граница
function M.bounds(camera_id, left, top, right, bottom) end

---Создает эффект встряски камеры
---@param camera_id? hash|string Идентификатор камеры (nil для первой камеры)
---@param intensity? number Интенсивность (по умолчанию 0.05)
---@param duration? number Длительность (по умолчанию 0.5)
---@param direction? hash Направление (SHAKE_BOTH, SHAKE_HORIZONTAL, SHAKE_VERTICAL)
---@param cb? function Функция обратного вызова по завершении
function M.shake(camera_id, intensity, duration, direction, cb) end

---Останавливает эффект встряски
---@param camera_id? hash|string Идентификатор камеры (nil для первой камеры)
function M.stop_shaking(camera_id) end

---Создает эффект отдачи камеры
---@param camera_id? hash|string Идентификатор камеры (nil для первой камеры)
---@param offset vector3 Смещение отдачи
---@param duration? number Длительность (по умолчанию 0.5)
function M.recoil(camera_id, offset, duration) end

---Устанавливает автоматический масштаб камеры
---@param camera_id? hash|string Идентификатор камеры (nil для первой камеры)
---@param enabled boolean Включить автоматический масштаб
function M.set_automatic_zoom(camera_id, enabled) end

---Устанавливает масштаб камеры
---@param camera_id? hash|string Идентификатор камеры (nil для первой камеры)
---@param zoom number Новый масштаб
function M.set_zoom(camera_id, zoom) end

---Возвращает текущий масштаб камеры
---@param camera_id? hash|string Идентификатор камеры (nil для первой камеры)
---@return number Текущий масштаб
function M.get_zoom(camera_id) end

---Возвращает матрицу проекции камеры
---@param camera_id? hash|string Идентификатор камеры (nil для первой камеры)
---@return matrix4 Матрица проекции
function M.get_projection(camera_id) end

---Возвращает матрицу вида камеры
---@param camera_id? hash|string Идентификатор камеры (nil для первой камеры)
---@return matrix4 Матрица вида
function M.get_view(camera_id) end

---Возвращает область просмотра камеры
---@param camera_id? hash|string Идентификатор камеры (nil для первой камеры)
---@return vector4 Область просмотра (x,y - левый нижний угол, z,w - ширина, высота)
function M.get_viewport(camera_id) end

---Возвращает смещение камеры
---@param camera_id? hash|string Идентификатор камеры (nil для первой камеры)
---@return vector3 Смещение камеры
function M.get_offset(camera_id) end

---Преобразует экранные координаты в мировые
---@param camera_id? hash|string Идентификатор камеры (nil для первой камеры)
---@param screen vector3 Экранные координаты
---@return vector3 Мировые координаты
function M.screen_to_world(camera_id, screen) end

---Преобразует оконные координаты в мировые
---@param camera_id? hash|string Идентификатор камеры (nil для первой камеры)
---@param window vector3 Оконные координаты (пиксели)
---@return vector3 Мировые координаты
function M.window_to_world(camera_id, window) end

---Преобразует мировые координаты в экранные
---@param camera_id? hash|string Идентификатор камеры (nil для первой камеры)
---@param world vector3 Мировые координаты
---@param adjust_mode? hash Режим адаптации GUI
---@return vector3 Экранные координаты
function M.world_to_screen(camera_id, world, adjust_mode) end

---Преобразует мировые координаты в оконные (пиксельные)
---@param camera_id? hash|string Идентификатор камеры (nil для первой камеры)
---@param world vector3 Мировые координаты
---@return vector3 Оконные координаты
function M.world_to_window(camera_id, world) end

---Проецирует мировые координаты на экран
---@param view matrix4 Матрица вида
---@param projection matrix4 Матрица проекции
---@param world vector3 Мировые координаты
---@return vector3 Экранные координаты (тот же объект)
function M.project(view, projection, world) end

---Обратное проецирование экранных координат в мировые
---@param view matrix4 Матрица вида
---@param projection matrix4 Матрица проекции
---@param screen vector3 Экранные координаты
---@return vector3 Мировые координаты (тот же объект)
function M.unproject(view, projection, screen) end

---Возвращает границы экрана в мировых координатах
---@param camera_id? hash|string Идентификатор камеры (nil для первой камеры)
---@return vector4 Границы (x - левая, y - верхняя, z - правая, w - нижняя)
function M.screen_to_world_bounds(camera_id) end

return M
