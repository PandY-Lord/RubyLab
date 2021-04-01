class CashMachine

  def initialize
    @balance = 100.0
    if File.exist?("balance.txt")
      f = File.open("balance.txt")
      @balance = f.read.to_f
      f.close
    end
  end

  def deposit(sum)
    if sum <= 0
      puts 'Сумма должна быть больше нуля'
    else
      @balance += sum
      puts "Ваш новый баланс: #{@balance}"
    end
  end

  def withdraw(sum)
    if sum <= 0
      puts 'Сумма должна быть больше нуля'
    elsif sum > @balance
      puts 'Недостаточно средств'
    else
      @balance -= sum
      puts "Ваш новый баланс: #{@balance}"
    end
  end

  def balance
    puts "Ваш баланс: #{@balance}"
  end

  def quit
    f = File.open('balance.txt', 'w')
    f.write(@balance)
    f.close
  end
end

cash_machine = CashMachine.new

loop do
  puts "
  (B) Баланс
  (D) Депозит
  (W) Вывод
  (Q) Quit"


  choose = gets.chomp
  case choose.downcase
  when 'd'
    puts 'Введите сумму для депозита'
    cash_machine.deposit(gets.to_f)
  when 'w'
    puts 'Введите сумму для списания'
    cash_machine.withdraw(gets.to_f)
  when 'b'
    cash_machine.balance
  when 'q'
    cash_machine.quit
    break
  else
    puts 'Нет такого варианта'
  end
end