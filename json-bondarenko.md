# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip : 71.78.22.43
            }
        ]
    }
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис

### Ваш скрипт:
Ответ
- нет ковычек в строке 9:
  
 1: { "info" : "Sample JSON output from our service\t",

 2:     "elements" :[
 
 3:         { "name" : "first",
 
 4:         "type" : "server",
 
 5:         "ip" : 7175 
 
 6:         },
 
 7:         { "name" : "second",
 
 8:         "type" : "proxy",
 
 9:         "ip": "71.78.22.43"

10:         }

11:     ]

12: }

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python

 #!/usr/bin/env python3

import socket as sok
import time as t
import datetime as dt
import json
import yaml

# set variables 
i     = 1
wait  = 2 # интервал проверок в секундах
servers   = {'drive.google.com':'0.0.0.0', 'mail.google.com':'0.0.0.0', 'google.com':'0.0.0.0'}
init  = 0
fpath = "/home/vagrant/phyton/" #путь к файлам конфигов
flog  = "/home/vagrant/phyton/error.log" #путь к файлам логов

# start script workflow
print('start check')
print(servers)
print('wait process')

while 1 == 1 : # для бесконечного цикла, else  установить условие i >= чилу треуемых итераций
  for host in servers:
    is_error = False 
    ip = sok.gethostbyname(host)
    if ip != servers[host]:
      if i==1 and init !=1: # вывод ошибки, если отсутствует инициализации или инициализация есть и не первый шаг
        is_error=True
        # вывод ошибок в файл
        with open(flog,'a') as fl:
          print(str(dt.datetime.now().strftime("%Y-%m-%d %H:%M:%S")) +' [ERROR] ' + str(host) +' IP mistmatch: '+servers[host]+' '+ip,file=fl)
        #******************************************
        # решение 4.3 - пункт 2
        # вывод в отдельные файлы
        # json
        with open(fpath+host+".json",'w') as jsf:
          json_data= json.dumps({host:ip})
          jsf.write(json_data) 
        # yaml
        with open(fpath+host+".yaml",'w') as ymf:
          yaml_data= yaml.dump([{host : ip}])
          ymf.write(yaml_data) 
    # вывод в один файл     
    if is_error:
      data = []  
      for host in servers:  
        data.append({host:ip})
      with open(fpath+"services_conf.json",'w') as jsf:
        json_data= json.dumps(data)
        jsf.write(json_data)
      with open(fpath+"services_conf.yaml",'w') as ymf:
        yaml_data= yaml.dump(data)
        ymf.write(yaml_data)
        #^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      servers[host]=ip
  #print(i) # вывод шага итерации для процесса отладки
  i+=1 # счетчик итераций для отладки. нужно закомментировать для бесконечного цикла
  if i >=50 : # число итераций для выхода из цикла для отладки
    break
  t.sleep(wait) # задержка на итерации 
```

### Вывод скрипта при запуске при тестировании:
```
vagrant@host-01:~$ ./script5-yaml.py
start check
{'drive.google.com': '0.0.0.0', 'mail.google.com': '0.0.0.0', 'google.com': '0.0.0.0'}
wait process
********************

vagrant@host-01:~$ ll
total 384
drwxr-xr-x 7 vagrant vagrant   4096 Feb 19 13:57 ./
drwxr-xr-x 3 root    root      4096 Jul 28  2021 ../
-rw------- 1 vagrant vagrant   3128 Feb 16 18:44 .bash_history
-rw-r--r-- 1 vagrant vagrant    220 Jul 28  2021 .bash_logout
-rw-r--r-- 1 vagrant vagrant   3771 Jul 28  2021 .bashrc
drwx------ 2 vagrant vagrant   4096 Jul 28  2021 .cache/
-rw-rw-r-- 1 vagrant vagrant    107 Feb 16 17:45 hosts.json
-rw-rw-r-- 1 vagrant vagrant     92 Feb 16 17:45 hosts.yaml
drwxrwxr-x 3 vagrant vagrant   4096 Feb 11 18:01 .local/
drwxrwxr-x 3 vagrant vagrant   4096 Feb 16 13:55 netology/
-rw------- 1 vagrant vagrant   3381 Feb 11 17:50 omni
-rw-r--r-- 1 vagrant vagrant    741 Feb 11 17:50 omni.pub
drwxrwxr-x 2 vagrant vagrant   4096 Feb 19 13:57 phyton/
-rw-r--r-- 1 vagrant vagrant    807 Jul 28  2021 .profile
-rwxrwxr-x 1 vagrant vagrant     47 Feb 16 11:27 script1.py*
-rwxrwxr-x 1 vagrant vagrant    355 Feb 16 16:33 script2.py*
-rwxrwxr-x 1 vagrant vagrant    772 Feb 16 17:04 script3.py*
-rwxrwxr-x 1 vagrant vagrant   1572 Feb 16 17:40 script41.py*
-rwxrwxr-x 1 vagrant vagrant    678 Feb 16 18:04 script4.py*
-rwxrwxr-x 1 vagrant vagrant   2494 Feb 19 13:57 script5-yaml.py*
drwx------ 2 vagrant root      4096 Feb 11 18:02 .ssh/
-rw-r--r-- 1 vagrant vagrant      0 Jul 28  2021 .sudo_as_admin_successful
-rw-rw-r-- 1 vagrant vagrant     19 Feb 16 16:39 test2.txt
-rw-rw-r-- 1 vagrant vagrant 288728 Feb 16 18:44 typescript
-rw-r--r-- 1 vagrant vagrant      6 Jul 28  2021 .vbox_version
-rw-r--r-- 1 root    root       180 Jul 28  2021 .wget-hsts
```

### json-файл(ы), который(е) записал ваш скрипт:
```json
-rw-rw-r-- 1 vagrant vagrant    107 Feb 16 17:45 hosts.json

vagrant@host-01:~$ cat hosts.json
{"drive.google.com": "64.233.161.194", "mail.google.com": "64.233.161.83", "google.com": "173.194.222.102"}

vagrant@host-01:~$

```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
-rw-rw-r-- 1 vagrant vagrant     92 Feb 16 17:45 hosts.yaml

vagrant@host-01:~$ cat hosts.yaml
drive.google.com: 64.233.161.194
google.com: 173.194.222.102
mail.google.com: 64.233.161.83

```