class User
  attr_accessor :age, :name, :phone, :address, :comments
  def initialize(name, age, phone, address, comments)
    @age = age
    @name = name
    @phone = phone
    @address = address
    @comments = comments
  end
end


class UserCollection
  def initialize
    @user_collection=[]
  end
  def add_user(user)
    @user_collection << user
  end
  def method_missing(name, params)
    if(name.to_s == 'sort_by_age!')
      @user_collection=@user_collection.sort {|a,b| a.age.to_i <=> b.age.to_i}
    end
    if(name.to_s == 'sort_by_name!')
      @user_collection.sort!{|a,b| a.name <=> b.name}
      puts params
    end
    if(name.to_s == 'sort_by_phone!')
      @user_collection.sort!{|a,b| a.phone.to_i <=> b.phone.to_i}
    end
    if(name.to_s == 'sort_by_address!')
      @user_collection.sort!{|a,b| a.address <=> b.address}
    end
    if(name.to_s == 'sort_by_comments!')
      @user_collection.sort!{|a,b| a.comments <=> b.comments}
    end
  end
  def print
    @user_collection.each{
      |man| puts (man.name+' '+ man.age+' '+ man.phone+' '+man.address+' '+man.comments)
    }
  end
end

class DataControl
  def initialize(path)
    @file=File.open(path)
  end
  def read(user_collection)
    @file.gets
    while (line = @file.gets) do
      line =line.split(',')
      user_collection.add_user(User.new(line[0],line[1],line[2],line[3],line[4]))
    end
  end
end



user_collection = UserCollection.new
data_control = DataControl.new('data.csv')
data_control.read(user_collection)
user_collection.sort_by_age!(true)
user_collection.print()