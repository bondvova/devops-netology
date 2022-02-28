# Домашнее задание к занятию "4.1. Командная оболочка Bash: Практические навыки"

## Обязательная задача 1

Есть скрипт:
```bash
a=1
b=2
c=a+b
d=$a+$b
e=$(($a+$b))
```

Какие значения переменным c,d,e будут присвоены? Почему?

| Переменная  | Значение | Обоснование |
| ------------- | ------------- | ------------- |
| `c`  | "a+b"  | ввиду того, что указан текст, а не переменные |
| `d`  | "1+3" | команда преобразовала и вывела значения переменных, но не произошло выполнения арифметической операции по причине того, что это строки |
| `e`  | "3"  | ввиду того, что за счет скобок запущена команда на выполнение арифметической операции со значениями переменных |


## Обязательная задача 2
На нашем локальном сервере упал сервис и мы написали скрипт, который постоянно проверяет его доступность, записывая дату проверок до тех пор, пока сервис не станет доступным (после чего скрипт должен завершиться). В скрипте допущена ошибка, из-за которой выполнение не может завершиться, при этом место на Жёстком Диске постоянно уменьшается. Что необходимо сделать, чтобы его исправить:
```bash
while ((1==1)
do
	curl https://localhost:4757
	if (($? != 0))
	then
		date >> curl.log
	fi
done
```

### Ваш скрипт:
```bash
    while (( 1 == 1 ))
    do
        curl https://localhost:4757
        if (($? != 0))
        then
            date >> curl.log
        else exit
        fi
        sleep 10
    done
```
    Пояснения:1. в условии while нет закрывающей скобки 
    2. нужно добавить sleep $timeout - для задания интервала проверки, чтобы слишком частые проверки не забивали диск.
    3. следует добавить проверку успешности, чтобы выйти из цикла
       например: else exit


## Обязательная задача 3
Необходимо написать скрипт, который проверяет доступность трёх IP: `192.168.0.1`, `173.194.222.113`, `87.250.250.242` по `80` порту и записывает результат в файл `log`. Проверять доступность необходимо пять раз для каждого узла.

### Ваш скрипт:
```bash
hosts=(192.168.0.1 173.194.222.113 87.250.250.24)
timeout=10
for i in {1..5}
do
date >> net_port_check.log
    for h in ${hosts[@]}
    do
	curl -Is --connect-timeout $timeout $h:80 >/dev/null
        echo "    check" $h status=$? >> net_port_check.log
    done
done
```

## Обязательная задача 4
Необходимо дописать скрипт из предыдущего задания так, чтобы он выполнялся до тех пор, пока один из узлов не окажется недоступным. Если любой из узлов недоступен - IP этого узла пишется в файл error, скрипт прерывается.

### Ваш скрипт:
```bash
hosts=(192.168.0.1 173.194.222.113 87.250.250.24)
timeout=10
res=0
while (($res == 0))
do
    for h in ${hosts[@]}
    do
	curl -Is --connect-timeout $timeout $h:80 >/dev/null
	res=$?
	if (($res != 0))
	then
	    echo "    ERROR on " $h status=$res >>hosts-fail.log
	fi
    done
done
```
