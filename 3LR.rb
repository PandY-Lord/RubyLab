

def task_1
  file = File.open('input.txt')
  #students = file.read.split("\n")
  students = file.readlines.map { |line|line.chomp }
  file.close
  result = []

  loop do
    puts "---------------
Введите возраст
---------------"
    input = gets.to_i
    break if input == -1 #выход -1

    students.each { |student|
      result.append(student) if student.split(' ')[2].to_i == input
    }
    break if students.length == result.length
  end

  file = File.open('result.txt', 'w')
  result.each { |s|
    puts s
    file.write(s + "\n")
  }
  file.close
end

def task_2
  balance = 100.0
  if File.exist?("balance.txt")
    file = File.open("balance.txt")
    balance = file.read.to_f
    file.close
  end
  loop do
    puts "-------------
B - Баланс
D - Депозит
W - Вывод
Q - Quit
-------------"

    choose = gets.chomp
    case choose.downcase
    when 'd'
      puts "-------------------------------------------
Введите сумму для депозита под 0.1% годовых
-------------------------------------------"
      sum = gets.to_f
      file = File.open('balance.txt', 'w')
      file.write(balance)
      if sum <= 0
        puts "-!-!-!-!-!-!-!-!-!-!-!-!-!-!-
Сумма не может быть равна нулю
-!-!-!-!-!-!-!-!-!-!-!-!-!-!-"
      else
        balance += sum
        puts "----------------------------------
Ваш новый баланс равен: #{balance}
----------------------------------"
        file = File.open('balance.txt', 'w')
        file.write(balance)
      end
    when 'w'
      puts "--------------------------
Введите сумму для списания
--------------------------"
      sum = gets.to_f
      file = File.open('balance.txt', 'w')
      file.write(balance)
      if sum <= 0
        puts "------------------------------
Сумма не может быть равна нулю
------------------------------"
      elsif sum > balance
        puts "-!-!-!-!-!-!-!-!-!-!-!-!-!-!-
Недостаточно средств
-!-!-!-!-!-!-!-!-!-!-!-!-!-!-"
      else
        balance -= sum
        puts "----------------------------
Ваш новый баланс: #{balance}
----------------------------"
        file = File.open('balance.txt', 'w')
        file.write(balance)
      end
    when 'b'
      puts "----------------------
Ваш баланс: #{balance}
----------------------"
    when 'q'
      file = File.open('balance.txt', 'w')
      file.write(balance)
      file.close
      break
    else
      puts "-!-!-!-!-!-!-!-!-!-!-!-!-!-!-
Некоректно выбран пункт меню
-!-!-!-!-!-!-!-!-!-!-!-!-!-!-"
    end
  end
end

def menu
  loop do
    puts "-------------
1 - Задание 1
2 - Задание 2
0 - Выход
-------------"

    choose = gets.to_i
    case choose
    when 1
      task_1
    when 2
      task_2

    when 0
      break
    else
      puts "-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-
Очень смешно, попробуй еще раз
-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-"
    end
  end
end

menu
