# Архитектура Будущее 2.0 учебный проект

Анализ текущего ландшафта и проектирование целевого решения. Внутри есть витрина данных доменная модель потоков и автоматизация инфраструктуры.

---

## 💡 Диаграммы и документация

- Диаграммы
  - Task2/dfd.drawio
  - Task4/diagram.drawio
  - C4 диаграмма в Task1/containers.puml рендер через PlantUML
- Документация
  - Task1/problems.md Task1/prioritization.md
  - Task2/domains.md
  - Task3/techradar.md Task3/justification.md
  - Task4/README.md Task4/justification.md

## 💡 Артефакты по заданиям

- Task1 целевая архитектура через год диаграмма контейнеров C4 анализ проблем приоритизация
- Task2 разделение на домены и DFD с потоками данных и обоснованием
- Task3 техрадар таблица с кольцами и роадмап изменений
- Task4 облачная инфраструктура на Terraform схема автоматизации и конфигурации

## 💡 Как открыть и просматривать

- .drawio файлы открыть в приложении draw.io Desktop или в браузере app.diagrams.net
- C4 открыть в редакторе с расширением PlantUML файл Task1/containers.puml
- Markdown файлы открыть напрямую в редакторе

## 💡 Структура проекта

```
.
├─ Task1/
│  ├─ README.md
│  ├─ containers.puml
│  ├─ problems.md
│  └─ prioritization.md
├─ Task2/
│  ├─ README.md
│  ├─ dfd.drawio
│  └─ domains.md
├─ Task3/
│  ├─ README.md
│  ├─ techradar.md
│  ├─ roadmap.drawio
│  └─ justification.md
├─ Task4/
│  ├─ README.md
│  ├─ diagram.drawio
│  ├─ yandex/
│  │  ├─ main.tf variables.tf outputs.tf
│  │  ├─ terraform.tfvars.example
│  │  ├─ work_logs.txt
│  │  └─ apply_screenshot.png пример файл для скриншота
│  └─ justification.md
└─ README.md
```

## 💡 Нефункциональные требования

- Безопасность и конфиденциальность данные хранятся в защищенных контурах шифрование на хранении и в передаче централизованные роли журналирование и аудит управление доступом по принципу минимальной достаточности
- Масштабируемость система поддерживает рост клиентов и направлений масштабирование по данным и по вычислениям
- Сопровождаемость и конфигурируемость артефакты и конфигурации написаны декларативно инфраструктура описана как код


