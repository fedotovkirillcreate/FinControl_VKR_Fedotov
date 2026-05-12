# ReconFlow B

Realtime MVP платформы автоматизированного учёта и контроля расчётных операций.

## Что внутри
- `/` — главный realtime-дашборд
- `/join` — мобильная QR-страница для зрителей
- `/control` — панель ведущего

## Локальный запуск
1. Скопируй `.env.example` в `.env`
2. Вставь `VITE_SUPABASE_URL` и `VITE_SUPABASE_ANON_KEY`
3. Выполни:

```bash
npm install
npm run dev
```

## Supabase
Выполни SQL из `supabase/schema.sql`, затем создай сессию на `/control`.

## Важно
Политики в SQL намеренно упрощены для demo-сценария. Перед реальным production их нужно ужесточить.
