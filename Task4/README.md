## Task4 Облачная инфраструктура IaaS и Terraform

### Состав
1. Конфигурация Terraform для сети виртуальной машины диска и NAT  
2. Схема автоматизации файл diagram.drawio  
3. Обоснование файл justification.md  

### Варинт для AWS
1. Установить Terraform и настроить учетные данные провайдера AWS через переменные окружения  
2. Перейти в директорию Task4/aws  
3. Выполнить команды ниже  

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

### Вариант для YClaud
1. Установить CLI `yc` и выполнить вход. Получить переменные `cloud_id` и `folder_id`  
2. Перейти в директорию Task4/yandex  
3. Внести значения в terraform.tfvars. Указать публичный SSH ключ и ключи доступа Object Storage  
4. Выполнить

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

### Состав ресурсов
1. VPC подсети интернет шлюз и NAT  
2. Маршрутизация для публичной и приватной подсетей  
3. Группа безопасности с входом по SSH из вашего диапазона  
4. В AWS Экземпляр EC2 и дополнительный EBS диск. В YC ВМ и вторичный диск  
5. В AWS S3 бакет. В YC Object Storage бакет  


