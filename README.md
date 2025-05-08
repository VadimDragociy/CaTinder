# catinder
https://www.flaticon.com/free-icons/dating-app - icon
https://icons8.com/icons/ - interface icons

Приложение для просмотра котов, Кототиндер Pro - дз по Flutter №3

Реализованы все технические и функциональные требования, код проходит статический анализ 

# С прошлой задачи:
# Главная страница:
![image](https://github.com/user-attachments/assets/0bf6b9c7-b461-4d74-8124-f05d0bdde134)


При заходе отображается рандомное изображение из Api
- Свайп влево = лайк, свайп вправо = дизлайк
- Кнопка лайка или свайп увеличивают счетчик лайков
- При нажатии на кота открывается его детальное описание

# Описание:
![image](https://github.com/user-attachments/assets/1808c47f-9fbc-4247-8aee-d3e9d917f129)

# Экран лайкнутых котов:
![image](https://github.com/user-attachments/assets/c2f3788d-5d91-450d-ba1d-6d6a379e9045)
# Фильтрация:
![image](https://github.com/user-attachments/assets/86d6fa17-f04e-4d80-b914-58dbb2f311fa)

# Новое:
### Счетчик и коты сохраняются после перезахода:
![image](https://github.com/user-attachments/assets/3c9b16b8-a225-4ed0-a83c-3d83b091b31b)
### При выходе в оффлайн всплывает уведомление:
![image](https://github.com/user-attachments/assets/7b675a3c-7e4c-404e-aab4-a1b048fd1eb9)
### При попытке подгрузить нового кота выдается ошибка:
![image](https://github.com/user-attachments/assets/ead12b0d-ddcf-4c85-b008-18428f140b33)
### Лайкнутые коты доступны в оффлайн:
![image](https://github.com/user-attachments/assets/2047f598-f135-4476-97b2-86c175e504f9)
![image](https://github.com/user-attachments/assets/5dfd3430-d968-4f14-bd8d-e23d45781465)


# Тесты:
![image](https://github.com/user-attachments/assets/cd1fac03-2f86-4ae5-b6f1-d1c4d3afb051)



## Cсылка для скачивания:
[https://drive.google.com/drive/u/1/folders/1KYOuFlgFuQFpvD8hSipWtp19D5vnMT7x](https://drive.google.com/file/d/1crc1MAgaj3kulwDma5mYzWLMOhwpr_cv/view?usp=drive_link)
(CaTinder Final)

## Код
- /tests - тесты
- /assets содержит иконки и интерфейсные иконки
- /lib содержит main.dart, injection_container.dart и подпапки
- /lib/screens содержит виджеты экранов
- /lib/models содержит модели котика и лайкнутого котика (с датой)
- /lib/data/cat_repository.dart - подгрузка новых котов
- /lib/data/local - база данных
- /lib/utils - утилиты
- /lib/domain/usecases/get_random_cat.dart - получение рандомного котика
- /lib/blocs - Bloc: загрузка котика, обработка состояний загрузки и ошибок; Cubit: хранение списка лайкнутых котиков, добавление и удаление карточки, фильтрация по породе

