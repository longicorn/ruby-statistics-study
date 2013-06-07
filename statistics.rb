#Ruby用統計ライブラリ
#勉強用
#statistics

class Array
  def to_statis
    ary=self.map{|x|x.to_f}
    Statistics.new(ary)
  end
end

class Statistics < Array
  def length
    super.to_f
  end

  def sum
    #合計
    self.inject(:+)
  end

  def range
    #範囲
    (self.max - self.min).abs
  end

  def mean
    #平均
    sum.to_f/self.length
  end

  def mean_w
    #重み付き平均
    #必要になったら作る
    mean #ひとまず、meanで
  end

  def median
    #中央値
    if self.length <= 2
      self.mean
    elsif (self.length%2==1)
      self[(self.length+1)/2]
    else
      (self[self.length/2] + self[self.length/2+1])/2.0
    end
  end

  def _var
    #分散
    m = mean
    self.inject(0){|s,x|s + (x-m)**2}/self.length
  end

  def _uvar
    #不偏分散
    m = mean
    self.inject(0){|s,x|s+(x-m)**2}/(self.length-1)
  end
  #分散の切り替え
  #alias :var :_var
  alias :var :_uvar #R/Excelはこっちなので、検算用

  def sd
    #標準偏差
    Math.sqrt(var)
  end

  def ss
    #偏差値
  end

  def cv
    #変動係数
    var/mean
  end

  def ske
    #歪度
    m = self.mean
    #sd2 = self.sd
    var2 = self.var

    #self.inject(0){|s,x|s+((x-m)/sd2)**3)}/self.length #数式通り
    self.inject(0){|s,x|s+((x-m)**3/var2**1.5)}/self.length
  end

  def kur
    #尖度
    m = self.mean
    #sd2 = self.sd
    var2 = self.var

    #self.inject(0){|s,x|s+((x-m)/sd2)**4}/self.length #数式通り
    self.inject(0){|s,x|s+(x-m)**4/var2**2}/self.length
  end

  def info
    #基本統計量
    puts "length:#{self.length.to_i}"
    puts "sum:#{self.sum}"
    puts "range:#{self.range}"
    puts "mean:#{self.mean}"
    puts "median:#{self.median}"
    puts "var:#{self.var}"
    puts "sd:#{self.sd}"
    #puts "ss:#{self.ss}"
    puts "cv:#{self.cv}"
    puts "ske:#{self.ske}"
    puts "kur:#{self.kur}"
  end

  def cov(array)
    #共分散
    array = array.to_statis
    mean_x = self.mean
    mean_y = array.mean

    self.zip(array).inject(0){|s,a|s + (a[0]-mean_x)*(a[1]-mean_y)}/self.length
  end

  def cc(array)
    #相関係数
    array = array.to_statis
    self.cov(array)/(self.var * array.var)
  end
end

array=[87,65,5,91,45,72,78,69,77,58].to_statis
array2=[75,10,90,54,32,70,80,50,20,10].to_statis
p array
array.info

p array.cov(array2)
p array.cc(array2)
