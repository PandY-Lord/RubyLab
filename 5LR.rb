require 'socket'

server = TCPServer.new(8080)

class CashMachine
  def initialize
    if File.exists?('balance.txt')
      balance_machine = File.open('balance.txt', 'r')
      @balance = balance_machine.read.chomp.to_f
    else
      balance_machine = File.open('balance.txt', 'w')
      balance_machine.puts('100.00')
      balance_machine.close
      balance_machine = File.open('balance.txt', 'r')
      @balance = balance_machine.read.chomp.to_f
    end
  end

  def withdraw(withdraw_machine)
    if withdraw_machine.negative?
      'Введено отрицательное число'
    end
    if @balance < withdraw_machine
      'Нехватает средств'
    end
    @balance -= withdraw_machine
    balance_machine = File.open('balance.txt', 'w')
    balance_machine.puts(@balance)
    balance_machine.close
    "New balance: #{@balance}"
  end

  def deposit(deposit_machine)
    if deposit_machine.negative?
      'Введено отрицательное число'
    end
    @balance += deposit_machine
    balance_machine = File.open('balance.txt', 'w')
    balance_machine.puts(@balance)
    balance_machine.close
    "New balance: #{@balance}"
  end

  def balance
    "Balance: #{@balance} \n"
  end

end

while (connection = server.accept)

  cash_machine = CashMachine.new

  request = connection.gets
  nothin, full_path = request.split(' ')

  # fiasco code, but it work
#  uri,num = full_path.split('?')
# case uri
# when '/balance'
#   connection.print "HTTP/1.1 200\r\n\n"
#   connection.print cash_machine.balance
# when 'withd'...
# end




  path = full_path.split('/')[1]
  if nothin == 'GET'
    if full_path.split('/')[1].include?('?')
      method = path.split('?')[0]
      value = path.split('?')[1].split('=')[1].to_i
    end

    connection.print "HTTP/1.1 200\r\n"
    connection.print "Content-Type: text/html\r\n"
    connection.print "\r\n"
    connection.print cash_machine.balance if path == 'balance'

    unless value.nil?
      connection.print case method
                       when 'deposit'
                         cash_machine.deposit(value)
                       when 'withdraw'
                         cash_machine.withdraw(value)
                       else
                         'error'
                       end
    end
  end

end
